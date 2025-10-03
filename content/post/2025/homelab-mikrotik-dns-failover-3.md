---
Date: 2025-04-26
Title: "Homelab - DNS failover (Episode 3)"
SubTitle: Avec le routeur MikroTik
Section: Informatique
Tags:
- Blog
- DevOps
- Homelab
- Opensource
- planet-libre
Image:
  src: "/img/2025/homelab-dns-failover.png"
  desc: "DNS failover"
Sources:
  - sitename: blog.jesuislibre.org
    link: https://blog.jesuislibre.org/homelab-dns-failover-episode-3
  - sitename: coredns.io
    link: https://coredns.io
  - sitename: mikrotik.com
    link: https://mikrotik.com
  - sitename: github.com
    link: https://github.com/badele/network-lab/tree/main/mikrotik-dns-failover
IA:
  - name: openai
    items:
      - Reformulation des phrases
      - Correction des fautes d'orthographe
      - Genération de l'image de garde (Dall-E)
---

**Les épisodes précédents :**

- [Homelab - Les bases (Episode 1)](https://blog.jesuislibre.org/homelab-les-bases-episode-1/)
- [Homelab - Le système d'exploitation (Episode 2)](https://blog.jesuislibre.org/homelab-systeme-exploitation-2/)
- [Homelab - DNS failover (Episode 3)](https://blog.jesuislibre.org/homelab-dns-failover-episode-3)

## Préface

Aujourd'hui, mon homelab est composé de trois machines (un Raspberry Pi 5, un
Microserver N40L, et un mini PC NiPoGi E3B). Au fil des évolutions et des
réorganisations de mon infrastructure, je recycle régulièrement des machines ou
des services. Il m'arrive donc d'éteindre des serveurs lorsqu'ils ne sont plus
nécessaires.

Mon objectif : que mes laptops pointent vers le serveur DNS de mon
[MikroTik](https://mikrotik.com/), lequel gère automatiquement le basculement
(failover) en fonction de la disponibilité des serveurs DNS.\
Pour cela, je mets à jour mes enregistrements DNS de manière déclarative avec
[CoreDNS](https://coredns.io/) et NixOS.

Afin d'éviter toute modification manuelle de la configuration du MikroTik, j'ai
mis en place un petit serveur DNS local avec CoreDNS. Cette approche me permet
de faire évoluer la configuration de manière propre et automatisée via NixOS.

Côté MikroTik, j'exploite les fonctionnalités `netwatch` et `scripts` pour que
le routeur ajuste automatiquement la liste des serveurs DNS disponibles en
fonction de l'état des hôtes (un vrai pseudo-failover !).

**Petite précision importante :**\
Ajouter plusieurs serveurs DNS dans `/etc/resolv.conf` **n'offre pas** de
failover efficace.\
Le système utilise toujours la première entrée. Ce n'est qu'en cas de timeout
qu'il essaie la suivante, ce qui n'est ni rapide ni optimal.

**Bonus :**\
Si vous voulez expérimenter ce setup sans MikroTik, j'ai créé un containerlab
[disponible ici](https://github.com/badele/network-lab/tree/main/mikrotik-dns-failover).

## Schéma d'architecture

Le MikroTik pointe vers plusieurs serveurs CoreDNS potentiels :

![diagram](https://raw.githubusercontent.com/badele/network-lab/refs/heads/main/mikrotik-dns-failover/diagram.svg)

## Mise en place du DNS

### Côté serveurs

J'utilise CoreDNS pour distribuer les entrées locales et faire du forwarding
vers l'extérieur.\
La configuration est entièrement gérée avec NixOS :
[voir ici](https://github.com/badele/nix-homelab/blob/main/nix/nixos/roles/coredns.nix).

### Côté MikroTik

Grâce à `netwatch`, je peux surveiller la disponibilité de mes serveurs. En
fonction de leur état (`up` ou `down`), un script est exécuté pour ajuster
dynamiquement la liste des DNS.

Imaginons que j'ai trois serveurs CoreDNS disponibles aux adresses suivantes :

- `172.100.100.2`
- `172.100.100.3`
- `172.100.100.4`

Voici le script MikroTik qui gère le pseudo-failover :

```bash
###############################################################################
# DNS configuration
###############################################################################
/system script
  add name=UpdateDNS dont-require-permissions=yes source="\
:local dnsServers \"\";\
:if ([/tool netwatch get [find host=172.100.100.2] status] = \"up\") do={ :set dnsServers (\$dnsServers . \"172.100.100.2,\") };\
:if ([/tool netwatch get [find host=172.100.100.3] status] = \"up\") do={ :set dnsServers (\$dnsServers . \"172.100.100.3,\") };\
:if ([/tool netwatch get [find host=172.100.100.4] status] = \"up\") do={ :set dnsServers (\$dnsServers . \"172.100.100.4,\") };\
/ip dns set servers=\$dnsServers"

/tool netwatch add host=172.100.100.2 interval=30s timeout=2s \
    up-script="/system script run UpdateDNS" \
    down-script="/system script run UpdateDNS"

/tool netwatch add host=172.100.100.3 interval=30s timeout=2s \
    up-script="/system script run UpdateDNS" \
    down-script="/system script run UpdateDNS"

/tool netwatch add host=172.100.100.4 interval=30s timeout=2s \
    up-script="/system script run UpdateDNS" \
    down-script="/system script run UpdateDNS"
```

### Vérifications

**En fonctionnement normal**

Commande `/tool/netwatch/print` :

```text
Columns: TYPE, HOST, TIMEOUT, INTERVAL, STATUS, SINCE
# TYPE    HOST           TIMEOUT  INTERVAL  STATUS  SINCE
0 simple  172.100.100.2  2s       30s       up      2025-04-27 10:24:19
1 simple  172.100.100.3  2s       30s       up      2025-04-27 10:24:19
2 simple  172.100.100.4  2s       30s       up      2025-04-27 10:24:19
```

Commande `/ip/dns/print` :

```text
servers: 172.100.100.2
         172.100.100.3
         172.100.100.4
```

**Simulation d'un failover**

J'ai volontairement éteint les serveurs `172.100.100.2` et `172.100.100.3`.
Voici ce que donne l'état du netwatch :

Commande `/tool/netwatch/print` :

```text
Columns: TYPE, HOST, TIMEOUT, INTERVAL, STATUS, SINCE
# TYPE    HOST           TIMEOUT  INTERVAL  STATUS  SINCE
0 simple  172.100.100.2  2s       30s       down    2025-04-27 21:37:52
1 simple  172.100.100.3  2s       30s       down    2025-04-27 21:37:52
2 simple  172.100.100.4  2s       30s       up      2025-04-27 21:38:46
```

Commande `/ip/dns/print` :

```text
servers: 172.100.100.4
```

Et voilà : en cas de panne de serveurs, la configuration DNS est mise à jour
automatiquement !

Pour rappel : vous pouvez également tester ce setup sans routeur MikroTik grâce
au containerlab que j'ai créé,
[disponible ici](https://github.com/badele/network-lab/tree/main/mikrotik-dns-failover).
