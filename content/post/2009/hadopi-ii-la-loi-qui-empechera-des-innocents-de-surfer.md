---
Date: 2009-09-17
Title: Hadopi II, la loi qui empêchera des innocents de surfer
Section: Informatique
Aliases: /2009/9/17/hadopi-ii-la-loi-qui-empechera-des-innocents-de-surfer
Tags:
- planet-libre
- Internet
- Sécurité
---


Considérons que le risque zéro n’existe pas, des innocents pourraient
éventuellement être accusés à tort avec la loi Hadopi. En effet, on aura
beau protéger sa box en suivant [les recommandations
suivantes](http://free.korben.info/index.php/Wifi_et_Box) , ce ne sera
pas assez suffisant pour éviter tous risques d’accusations.

Je vais tenter de démontrer une attaque qui pourrait se produire sur une
box correctement sécurisée.

Contrairement à [l’article
précédent](http://blog.jesuislibre.org/2009/06/la-loi-hadopi-mise-a-mal-par-freewifi/)
l’attaque ne va pas consister à se faire passer pour un hotspot
FreeWifi, mais pour un utilisateur authentifié FreeWifi.

**Petit rappel de fonctionnement des hotspots FreeWifi**

Chaque freebox V5 de chaque abonné se comporte également comme un
hotspot FreeWifi. Si l’abonné a activé son hotspot, il pourra par la
suite profiter de l’ensemble des hotspots mis à disposition par les
abonnés Free( l’accès est protégé par un code).

Lors du premier accès à un des hotspot freewifi, une adresse IP vous
sera allouée automatiquement via DHCP et vous serez redirigé vers le
portail captif sécurisé de freewifi. L’authentification se fait donc de
façon sécurisée (HTTPS), ce qui évite à priori de vous faire voler vos
identifiants.

Néanmoins une fois l’étape d’authentification passée, et durant toute la
durée du surf, les données transitent en clair.

Par conséquent, malgré l’impression de sécurité durant la phase
d’authentification, l’utilisateur n’est en aucun cas protégé.

**Note**: Il semblerait qu’à chaque appel du serveur DHCP, l’utilisateur
soit dirigé de nouveau sur le portail captif (perte de session).

L’usurpation
------------

L’usurpation va consister à récupérer l’adresse mac ainsi que l’adresse
IP du véritable utilisateur qui transite en clair, pour pouvoir ensuite
se connecter à sa place.

1)  **Passage de la carte wifi en mode monitor**

{{< highlight bash>}}
airmon-ng start wlan0
{{< /highlight>}}

2)  **Recherche de l’adresse mac et l’ip avec wireshark**
    1.  Lancer wireshark
    2.  Activer le filtre « tcp.srcport == 80″
    3.  Capturer les paquets
    4.  Rechercher ensuite l’adresse IP (1) et de l’adresse mac (2) de
        la victime

<img src="/img/2009/wireshark-freewifi.jpg" width="75%" alt="wireshark" />

3)  **Changement de l’adresse mac de votre carte wifi**

{{< highlight bash>}}
airmon-ng stop mon0
ifconfig wlan0 down
macchanger -m XX:XX:XX:XX:XX
ifconfig wlan0 up
{{< /highlight>}}

A chaque appel du serveur DHCP, la page du portail captif et de nouveau
réinitialisée ( vos login et password vous seront demandés à nouveau).
Pour éviter cela, il faut configurer le réseau en mode statique.

4)  **Configuration statique**

Exemple de configuration avec wicd

    > 1.  IP: xx.xx.xx.xx
    > 2.  DNS: 212.27.40.241, 212.27.40.242
    > 3.  Mask: 255.255.128.0
    > 4.  Route: 78.251.127.254

**Problèmes rencontrés**

Il peut arriver d’avoir des conflits lors du surf, car à un moment donné
les 2 cartes réseau (celle de l’utilisateur et de l’attaquant) auront
les adresses MAC identiques. Je crois que la technique du de-auth
devrait faire l’affaire.

**Conclusion**

En clair, même avec peu de connaissances en hacking wifi, un attaquant
peut utiliser votre connexion Wifi, et surfer en votre nom.

Cette loi pourrait éloigner les débutant désirant s’abonner à internet,
craignant d’être accusés à tort pour téléchargement illégal et devoir
payer l’amende de 1500Eu.

<div id="comments">


<h3 id="comments-title">3 réponses à <em>Hadopi II, la loi qui empêchera des innocents de surfer</em></h3>


<ol class="commentlist">
<li id="li-comment-29" class="comment even thread-even depth-1">
<div id="comment-29">
<div class="comment-author vcard">
<img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/22a1ad2903aac14eedec1e8655fbc46d?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com29">            <cite class="fn"><a class="url" rel="external nofollow" href="http://flood.fr">KTR</a></cite> <span class="says">dit&nbsp;:</span>      </div><!-- .comment-author .vcard -->

<div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/09/hadopi-ii-la-loi-qui-empechera-des-innocents-de-surfer/comment-page-1/#comment-29">
17 septembre 2009 à 11 h 48 min</a>        </div><!-- .comment-meta .commentmetadata -->

<div class="comment-body"><p>Lulz <img class="wp-smiley" alt=":D" src="http://blog.jesuislibre.org/wp-includes/images/smilies/icon_biggrin.gif"> </p>
<p>\o/</p>
<p>Internet wins !</p>
</div>

<div class="reply">
</div><!-- .reply -->
</div><!-- #comment-##  -->

</li>
<li id="li-comment-30" class="comment odd alt thread-odd thread-alt depth-1">
<div id="comment-30">
<div class="comment-author vcard">
<img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/16f8abf859f89ee1b2deb99bbad4b9b2?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com30">            <cite class="fn">boulate</cite> <span class="says">dit&nbsp;:</span>        </div><!-- .comment-author .vcard -->

<div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/09/hadopi-ii-la-loi-qui-empechera-des-innocents-de-surfer/comment-page-1/#comment-30">
17 septembre 2009 à 19 h 06 min</a>        </div><!-- .comment-meta .commentmetadata -->

<div class="comment-body"><p>Pourquoi utiliser macchanger (qui nécéssite des paquets supplémentaires), alors qu’un simple ifconfig permet de changer son @MAC ?</p>
<p>ifconfig eth0 hw ether 00:XX:XX:XX:XX:XX</p>
<p>La question que je me pose : L’adresse IP publique du coté FreeWifi est elle la même que celle de l’abonné (il ne me semble pas).<br>
Si tu es connecté du coté FreeWifi, je ne pense pas que le titulaire de la ligne soit mis en cause (même si tu as la même @MAC que son pc). Le coté FreeWifi (et donc l’@IP qui va avec) ne le concerne pas.</p>
<p>Je dis peut être une bêtise hein, c’est juste une question.</p>
</div>

<div class="reply">
</div><!-- .reply -->
</div><!-- #comment-##  -->

</li>
<li id="li-comment-31" class="comment byuser comment-author-b_adele bypostauthor even thread-even depth-1">
<div id="comment-31">
<div class="comment-author vcard">
<img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/f4a804b1c2256bdefb9674105039dd98?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com31">            <cite class="fn"><a class="url" rel="external nofollow" href="http://www.jesuislibre.org">b_adele</a></cite> <span class="says">dit&nbsp;:</span>       </div><!-- .comment-author .vcard -->

<div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/09/hadopi-ii-la-loi-qui-empechera-des-innocents-de-surfer/comment-page-1/#comment-31">
18 septembre 2009 à 8 h 38 min</a>     </div><!-- .comment-meta .commentmetadata -->

<div class="comment-body"><blockquote><p>Pourquoi utiliser macchanger (qui nécéssite des paquets supplémentaires), alors qu’un simple ifconfig permet de changer son @MAC ?</p>
<p>ifconfig eth0 hw ether 00:XX:XX:XX:XX:XX</p></blockquote>
<p>Je ne connaissais pas cette technique, effectivement c’est plus éfficace et cela fait effectivement un paquet en moins à installer <img class="wp-smiley" alt=":)" src="http://blog.jesuislibre.org/wp-includes/images/smilies/icon_smile.gif"> </p>
<blockquote><p>La question que je me pose : L’adresse IP publique du coté FreeWifi est elle la même que celle de l’abonné (il ne me semble pas).<br>
Si tu es connecté du coté FreeWifi, je ne pense pas que le titulaire de la ligne soit mis en cause (même si tu as la même @MAC que son pc). Le coté FreeWifi (et donc l’@IP qui va avec) ne le concerne pas.</p></blockquote>
<p>L’addresse IP du hotspot freewifi n’est effectivement pas la même que c’elle de l’abonné, néanmoins il te faut utiliser le login et password crée depuis ta freebox. C’est donc le couple  login/password qui permettra d’identifier quel abonné s’est identifié sur quel hotspot et quelle activité il à eu. c’est du moins comme ça que les autoritées risque de l’interpréter.</p>
</div>

<div class="reply">
</div><!-- .reply -->
</div><!-- #comment-##  -->

</li>
</ol>
</div>
