---
Date: 2024-11-18
Title: "Homelab - Les bases (Episode 1)"
SubTitle: Architecture et Réseau
Section: Informatique
Tags:
- Blog
- DevOps
- Homelab
- Opensource
- planet-libre
Image: "/img/2024/homelab_retro.png"
BigImg:
- {src: "/img/2024/homelab_retro.png", desc: "homelab retro"}
---

**Les épisodes :**

- [Homelab - Les bases (Episode 1)](https://blog.jesuislibre.org/homelab-les-bases-episode-1/)
- [Homelab - Le système d'exploitation (Episode 2)](https://blog.jesuislibre.org/homelab-le-syst%C3%A8me-dexploitation-episode-2/)

## Preface

J'ai commencé à utiliser Internet dans les années 90, via des
[BBS](https://fr.wikipedia.org/wiki/Bulletin_board_system) ou le
[Minitel](https://fr.wikipedia.org/wiki/Minitel). J’ai été témoin de ses
évolutions, des premiers serveurs personnels jusqu’aux grandes plateformes. J’ai
créé mes propres serveurs web, géré mes serveurs de messagerie, puis, peu à peu,
je me suis laissé séduire par des services centralisés tels que Gmail, Google
Reader, Flickr, Twitter, etc.

C’est pourquoi j’ai décidé de créer une infrastructure homemade, en
auto-hébergement, pour regagner en autonomie et assurer le contrôle de mes
données, non seulement pour moi, mais aussi pour ma famille. Au lieu de confier
nos messages, nos photos ou nos données de santé à des tiers, elles resteront
chez moi, en sécurité.

À travers ce blog, je vais partager les étapes de ce projet d’auto-hébergement :
de la mise en place des services à leur gestion. Ces billets seront rédigés au
fur et à mesure de mon avancée, avec l’idée de rendre cette démarche accessible
à ceux qui, comme moi, souhaitent reprendre en main leur vie numérique.

## Architecture

Mon homelab reposera sur une architecture simple et optimisée, utilisant dans la
mesure du possible matériel de récupération (en fonction de sa consommation
énergétique )

L'objectif est de mettre en place des services orientés vers le
[Disaster Recovery](https://fr.wikipedia.org/wiki/Plan_de_reprise_d%27activit%C3%A9_(informatique))
plutôt que la redondance complète, contrairement aux pratiques courantes en
entreprise. Ce homelab repose sur trois routeurs Mikrotik, de deux serveurs HP
Microserver Proliant N40L, et d’un Raspberry Pi 4, chacun apportant des
capacités adaptées pour tester une variété de services.

Le Microserver N40L, avec 8 Go de RAM et deux disques de 2 To en miroir ZFS,
offre une base solide pour le stockage et le traitement. Le Raspberry Pi 4,
également équipé de 8 Go de RAM et d’un disque externe de 465 Go, étend le
homelab avec une option flexible pour les tâches secondaires et les services
additionnels.

En privilégiant le Disaster Recovery, cette approche permet d’optimiser les
coûts et la consommation électrique, tout en maintenant une certaine résilience.

Je pense baser mon homelab sur la distribution [NixOS](https://nixos.org/) +
l'hyperviseur [Incus](https://linuxcontainers.org/incus/)

Le materiel utilisé pour la conception de ce homelab

|  device  |                           model                            |                               description                                |
| :------: | :--------------------------------------------------------: | :----------------------------------------------------------------------: |
| routeur  |                    RB4011iGS+5HacQ2HnD                     |                               Routeur Wifi                               |
| routeur  |                      RB2011UiAS-2HnD                       |                               Routeur Wifi                               |
| routeur  |                          RB750GL                           |                              Routeur/Switch                              |
| computer | NiPoGi AMD 64 bits Ryzen 73750H / 16Go RAM / 512 Go disque |        NiPoGi AMD 64 bits Ryzen 73750H / 16Go RAM / 512 Go disque        |
| computer |                    HP Microserver N40L                     | AMD 64 bits Dual Core 1.5 Ghz Turion II Neo N40L / 8Go RAM / 4 To disque |
| computer |                       Raspberry Pi 4                       |     ARM 64 bits Quad core 600Mhz cortex-a72 / 8Go RAM / 500Go disque     |

## Réseau

Avant de pouvoir utiliser un homelab, il est essentiel de structurer son réseau
afin d'isoler

Pour cela, j'ai choisi de baser mon réseau sur des routeurs
[Mikrotik](https://mikrotik.com/). Ces équipements offrent des solutions
professionnelles abordables avec une grande flexibilité, Ce qui les rend idéaux
pour mon projet.

Auparavant, mon réseau local utilisait la plage d’adresses `192.168.254.0/24`.
Désormais, pour concevoir un réseau adapté à mon homelab, je vais exploiter les
capacités VLAN de mes Mikrotik afin d'isoler certains flux.

En respectant la structure de mon réseau d'origine, j'ai configuré des
sous-réseaux avec un masque de **`/20`**. Cela permet de diviser mon réseau en :

- 16 catégories principales de VLAN
- 16 VLAN pour chaque catégorie

### Zones VLAN

| Zone VLAN                      | Réseau           |
| ------------------------------ | ---------------- |
| Privé (LAN, ADM)               | 192.168.240.0/20 |
|                                | 192.168.224.0/20 |
|                                | 192.168.208.0/20 |
|                                | 192.168.192.0/20 |
|                                | 192.168.176.0/20 |
|                                | 192.168.160.0/20 |
|                                | 192.168.144.0/20 |
|                                | 192.168.128.0/20 |
|                                | 192.168.112.0/20 |
|                                | 192.168.96.0/20  |
|                                | 192.168.80.0/20  |
|                                | 192.168.64.0/20  |
|                                | 192.168.48.0/20  |
| Zone démilitarisée (DMZ, CTTV) | 192.168.32.0/20  |
|                                | 192.168.16.0/20  |
| Zone de guerre (WAR)           | 192.168.0.0/20   |

### Allocation VLAN

|     Zone VLAN      | VLAN ID | Réseau VLAN  |     Adresse      |   Description    |
| :----------------: | :-----: | :----------: | :--------------: | :--------------: |
|       Privé        |   254   |     LAN      | 192.168.254.0/24 |   Réseau local   |
|       Privé        |   240   |     ADM      | 192.168.240.0/24 | Ressources admin |
| Zone démilitarisée |   32    |     DMZ      | 192.168.32.0/24  |                  |
|   Zone de guerre   |    0    | Internet Box |  192.168.0.0/24  |                  |

### Exemple de catégorisation des équipements

| Préfixe de périphérique | Description       | Réseau de périphérique | Utilisé dans le VLAN | Appareils                             |
| ----------------------- | ----------------- | ---------------------- | -------------------- | ------------------------------------- |
| mikrotik                | Routeur           | 192.168.x.240/28       | ADM, LAN, DMZ, WAR   | mikrotik254, mikrotik253, mikrotik252 |
| hype                    | Hyperviseur Incus | 192.168.x.16/28        | ADM, LAN, DMZ        | hype16, hype17, hype18                |
| store                   | storage servers   | 192.168.x.32/28        | ADM, LAN, DMZ        | store32, store33                      |

Dans chaque sous-réseau, je vais, autant que possible, catégoriser par type de
périphérique en utilisant un masque de **`/28`**, offrant une capacité de 16
appareils par sous-réseau.

### Schema réseau

![Diagramme de réseau](/img/2024/homelab-network.svg)

### Configuration des VLANS

Je vais vous montrer comment configurer des routeurs Mikrotik afin de concevoir
un réseau basé sur des VLAN.

Bien que les routeurs mikrotik sont configurable graphiquement, je préfère les
configurer en ligne de commande. Ca me permet d'une part de faciliter le partage
d'informations (comme ici), mais d'autre part, de me créer une bibliothèque de
code reproductible.

Avant d’exécuter les commandes suivantes, je m'assure d'avoir activé le **mode
sécurisé** (**safe mode**) du routeur. Le **safe mode** me protègera d'une
erreur de configuration du routeur, comme une mauvaise configuration du firewall
ou le **vlan filtering** du bridge par exemple. Pour activer le **safe mode**,
je presse les touches **CTRL-x** dans le terminal.

**Comment fonctionne le safe mode ?**

Le **safe mode** permet de détecter une coupure de connexion a son routeur
pendant la phase de configuration, lorsque celui-ci détecte une perte de
connexion, il restaure la configuration précédentede. Personnellement, le safe
mode m’a sauvé à plusieurs reprises !

**Exemple de configuration**

Je vous propose un exemple de configuration pour mon routeur Mikrotik254
(adresse IP `x.x.x.254`)

```bash
# Note: Press [CTRL-x] In the terminal prompt, after the prompt line, you must see <SAFE> text

# Disables vlan filtering to avoid losing access to the router with the following commands
/interface/bridge
set [find where name="bridge"] vlan-filtering=no

# Enable all interface with vlan-lan(254) untagged PVID
/interface/bridge
port set [find where pvid !=254] pvid=254

# Add untagged vlan-adm interface
/interface/bridge
port set [where interface=ether10] pvid=240

# Configure trunk
/interface/bridge/vlan
add bridge=bridge comment=eth2-adm tagged=ether2,bridge vlan-ids=240
add bridge=bridge comment=eth2-lan tagged=ether2,bridge vlan-ids=254
add bridge=bridge comment=eth2-dmz tagged=ether2,bridge vlan-ids=32

# Create VLANs interfaces
/interface/vlan
add interface=bridge name=vlan-adm vlan-id=240
add interface=bridge name=vlan-dmz vlan-id=32
add interface=bridge name=vlan-lan vlan-id=254

# Address
/ip/address
add address=192.168.254.254/24 interface=vlan-lan network=192.168.254.0
add address=192.168.32.254/24  interface=vlan-dmz network=192.168.32.0
add address=192.168.240.254/24 interface=vlan-adm network=192.168.240.0


# Address pool for dhcp-server
/ip/pool
add name=dhcp-lan ranges=192.168.254.128/25
add name=dhcp-adm ranges=192.168.240.128/25

# Add DHCP server for all VLANs
/ip dhcp-server
add address-pool=dhcp-lan interface=vlan-lan lease-time=10m name="lan DHCP"
add address-pool=dhcp-adm interface=vlan-adm lease-time=10m name="adm DHCP"

# Interface list for the next firewall rules
/interface list
add comment=defconf name=WAN
add comment=defconf name=LAN

/interface list member
add interface=bridge list=LAN
add interface=vlan-lan list=LAN
add interface=vlan-adm list=LAN
add interface=ether1 list=WAN
```

##### Application de la configuration

Pour préserver l’ensemble de la configuration précédente (étant toujours en mode
`<SAFE>`), je ressort du safe mode en pressant les touches **CTRL-x**.

Je peux dorénavant passer à l'activation du **VLAN filtering**, en exécutant les
commandes suivantes (en n'oubliant pas d'activer le safe mode):

```bash
# Note: Press [CTRL-x] In the terminal prompt, after the prompt line, you must see <SAFE> text

# Enable vlan filtering
/interface/bridge
set [find where name="bridge"] ] vlan-filtering=yes
```

Je sort du safe mode et mon routeur est prêt !

Si vous souhaitez en savoir plus sur les commandes MikroTik, j'ai créé une
[page dédiée](https://devops.jesuislibre.org/networking/mikrotik/).

La suite au prochain épisode ...

## Sources

- Site webs
  - [fr.wikipedia.org](https://fr.wikipedia.org)
  - [help.mikrotik.com](https://help.mikrotik.com)
  - [mikrotik.com](https://mikrotik.com)
  - [linuxcontainers.org](https://linuxcontainer.org)
  - [nixos.org](https://nixos.org)
- IA
  - openai
    - Reformulation des phrases
    - Correction des fautes d'orthographe
    - Genération de l'image de garde (Dall-E)
