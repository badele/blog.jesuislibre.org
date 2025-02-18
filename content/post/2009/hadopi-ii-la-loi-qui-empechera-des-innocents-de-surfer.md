---
Date: 2009-09-17
Title: Hadopi II, la loi qui empêchera des innocents de surfer
Section: Informatique
Aliases: /2009/9/17/hadopi-ii-la-loi-qui-empechera-des-innocents-de-surfer
Tags:
- planet-libre
- Internet
- Sécurité
Sources:
  - sitename: free.korben.info
    link: https://free.korben.info/index.php/Wifi_et_Box
  - sitename: blog.jesuislibre.org
    link: https://blog.jesuislibre.org/2009/06/la-loi-hadopi-mise-a-mal-par-freewifi/
---

Considérons que le risque zéro n’existe pas, des innocents pourraient
éventuellement être accusés à tort avec la loi Hadopi. En effet, on aura beau
protéger sa box en suivant
[les recommandations suivantes](http://free.korben.info/index.php/Wifi_et_Box) ,
ce ne sera pas assez suffisant pour éviter tous risques d’accusations.

Je vais tenter de démontrer une attaque qui pourrait se produire sur une box
correctement sécurisée.

Contrairement à
[l’article précédent](http://blog.jesuislibre.org/2009/06/la-loi-hadopi-mise-a-mal-par-freewifi/)
l’attaque ne va pas consister à se faire passer pour un hotspot FreeWifi, mais
pour un utilisateur authentifié FreeWifi.

**Petit rappel de fonctionnement des hotspots FreeWifi**

Chaque freebox V5 de chaque abonné se comporte également comme un hotspot
FreeWifi. Si l’abonné a activé son hotspot, il pourra par la suite profiter de
l’ensemble des hotspots mis à disposition par les abonnés Free( l’accès est
protégé par un code).

Lors du premier accès à un des hotspot freewifi, une adresse IP vous sera
allouée automatiquement via DHCP et vous serez redirigé vers le portail captif
sécurisé de freewifi. L’authentification se fait donc de façon sécurisée
(HTTPS), ce qui évite à priori de vous faire voler vos identifiants.

Néanmoins une fois l’étape d’authentification passée, et durant toute la durée
du surf, les données transitent en clair.

Par conséquent, malgré l’impression de sécurité durant la phase
d’authentification, l’utilisateur n’est en aucun cas protégé.

**Note**: Il semblerait qu’à chaque appel du serveur DHCP, l’utilisateur soit
dirigé de nouveau sur le portail captif (perte de session).

## L’usurpation

L’usurpation va consister à récupérer l’adresse mac ainsi que l’adresse IP du
véritable utilisateur qui transite en clair, pour pouvoir ensuite se connecter à
sa place.

1. **Passage de la carte wifi en mode monitor**

```bash
airmon-ng start wlan0
```

2. **Recherche de l’adresse mac et l’ip avec wireshark**
   1. Lancer wireshark
   2. Activer le filtre « tcp.srcport == 80″
   3. Capturer les paquets
   4. Rechercher ensuite l’adresse IP (1) et de l’adresse mac (2) de la victime

<img src="/img/2009/wireshark-freewifi_vga_palette_crt_effects.jpg" width="75%" alt="wireshark" />

3. **Changement de l’adresse mac de votre carte wifi**

```bash
airmon-ng stop mon0 ifconfig wlan0 down macchanger -m
XX:XX:XX:XX:XX ifconfig wlan0 up
```

A chaque appel du serveur DHCP, la page du portail captif et de nouveau
réinitialisée ( vos login et password vous seront demandés à nouveau). Pour
éviter cela, il faut configurer le réseau en mode statique.

4. **Configuration statique**

Exemple de configuration avec wicd

    > 1.  IP: xx.xx.xx.xx
    > 2.  DNS: 212.27.40.241, 212.27.40.242
    > 3.  Mask: 255.255.128.0
    > 4.  Route: 78.251.127.254

**Problèmes rencontrés**

Il peut arriver d’avoir des conflits lors du surf, car à un moment donné les 2
cartes réseau (celle de l’utilisateur et de l’attaquant) auront les adresses MAC
identiques. Je crois que la technique du de-auth devrait faire l’affaire.

**Conclusion**

En clair, même avec peu de connaissances en hacking wifi, un attaquant peut
utiliser votre connexion Wifi, et surfer en votre nom.

Cette loi pourrait éloigner les débutant désirant s’abonner à internet,
craignant d’être accusés à tort pour téléchargement illégal et devoir payer
l’amende de 1500Eu.
