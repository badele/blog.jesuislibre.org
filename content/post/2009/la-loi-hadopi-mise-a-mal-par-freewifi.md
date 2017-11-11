---
Date: 2009-06-05
Title: La loi Hadopi mise à mal par freewifi ?
Section: Informatique
Aliases: /2009/6/5/la-loi-hadopi-mise-a-mal-par-freewifi
Tags:
- planet-libre
- Internet
- Sécurité
---


![Copie d'ecran de freewifi](/img/2009/freewifi.jpg)

Pour les quelques personnes qui n’auraient pas encore entendu parlé de
la loi HADOPI. Cette loi est sensée couper les lignes internet des
soit-disant pirates. Donc pour prouver votre innocence, il vous sera
conseillé de acheter un mouchard.

Mais n’ayez aucune crainte car Madame Albanel dit: :

> Si vous ne piratez pas, non seulement vous ne risquez pas de suspension
> et vous n’êtes pas obligés de mettre un logiciel de sécurisation

Or, cet argument ne tient pas la route, car même un honnête internaute
pourra être accusé de piratage.

**Scénario possible** (non détaillé)

Un pirate créait un hotspot freewifi bidon. Ce hotspot aura pour mission
de faire croire que c’est un hotspot officiel. Il pourra éventuellement
utiliser la technique du Cross Site Scripting (XSS) + iframe pour
afficher la page officielle et y ajouter du code pour récupérer vos
identifiants.

Un utilisateur non averti, n’y verra que du feu ! Une fois les
identifiants récupérés, le pirate aura accès à environ 6 millions de
hotspots.

Il ne manquera plus qu’à l’équipe de Mme Albanel de vous accuser de
pirate (désolés vous n’avez pas acheté de mouchard).

<div id="comments">


<h3 id="comments-title">4 réponses à <em>La loi Hadopi mise à mal par freewifi ?</em></h3>


<ol class="commentlist">
<li id="li-comment-22" class="comment even thread-even depth-1">
<div id="comment-22">
<div class="comment-author vcard">
<img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/6d1db9ff40d653b409cda4c3ec45e5d7?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com22">            <cite class="fn">moule</cite> <span class="says">dit&nbsp;:</span>      </div><!-- .comment-author .vcard -->

<div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/06/la-loi-hadopi-mise-a-mal-par-freewifi/comment-page-1/#comment-22">
5 juin 2009 à 16 h 10 min</a>      </div><!-- .comment-meta .commentmetadata -->

<div class="comment-body"><p>Faudra m’expliquer comment tu fais pour avoir le certificat privé de free pour faire du man-in-the-middle avec https</p>
</div>

<div class="reply">
</div><!-- .reply -->
</div><!-- #comment-##  -->

</li>
<li id="li-comment-23" class="comment odd alt thread-odd thread-alt depth-1">
<div id="comment-23">
<div class="comment-author vcard">
<img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/b8c08f9906b3e638ef607f066cbc9b9c?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com23">            <cite class="fn"><a class="url" rel="external nofollow" href="http://nyquist.life.free.fr">nyquist</a></cite> <span class="says">dit&nbsp;:</span>      </div><!-- .comment-author .vcard -->

<div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/06/la-loi-hadopi-mise-a-mal-par-freewifi/comment-page-1/#comment-23">
5 juin 2009 à 16 h 58 min</a>      </div><!-- .comment-meta .commentmetadata -->

<div class="comment-body"><p>J’espère quand même que le site de free sera en https et signé par un certificat validé par une autorité reconnu.<br>
Je ne connais pas la technique du Cross Site Scripting (XSS) + iframe. Mais j’espere que la méthode certificat + https n’est pas sensible a ce genre d’attaque.</p>
</div>

<div class="reply">
</div><!-- .reply -->
</div><!-- #comment-##  -->

</li>
<li id="li-comment-25" class="comment byuser comment-author-b_adele bypostauthor even thread-even depth-1">
<div id="comment-25">
<div class="comment-author vcard">
<img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/f4a804b1c2256bdefb9674105039dd98?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com25">            <cite class="fn"><a class="url" rel="external nofollow" href="http://www.jesuislibre.org">b_adele</a></cite> <span class="says">dit&nbsp;:</span>       </div><!-- .comment-author .vcard -->

<div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/06/la-loi-hadopi-mise-a-mal-par-freewifi/comment-page-1/#comment-25">
5 juin 2009 à 19 h 30 min</a>      </div><!-- .comment-meta .commentmetadata -->

<div class="comment-body"><p><a rel="nofollow" href="#comment-23">@nyquist</a><br>
C’est justement le problème avec le https, c’est qu’on lui fait trop confiance, car il est juste la pour crypter et certifier que la page n’a pas été altérée entre le serveur et le client, mais si on arrive à faire du XSS, cette page sera considéré comme valide.</p>
<p>Voici un exemple de XSS avec le site paypal, l’attaquant est arrivé à afficher un message javascript et pourtant le site est considéré comme sûr ( barre d’adresse verte + cadenas).</p>
<p><a rel="nofollow" href="http://news.netcraft.com/archives/2008/05/16/paypal_xss_vulnerability_undermines_ev_ssl_security.html">http://news.netcraft.com/archives/2008/05/16/paypal_xss_vulnerability_undermines_ev_ssl_security.html</a></p>
<p>Un autre lien<br>
<a rel="nofollow" href="http://www.nexen.net/actualites/securite/18147-ssl_ne_peut_rien_contre_les_xss.php">http://www.nexen.net/actualites/securite/18147-ssl_ne_peut_rien_contre_les_xss.php</a></p>
</div>

<div class="reply">
</div><!-- .reply -->
</div><!-- #comment-##  -->

</li>
<li id="li-comment-26" class="comment odd alt thread-odd thread-alt depth-1">
<div id="comment-26">
<div class="comment-author vcard">
<img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/25c37368c75d9de77299b8fbb6d8b843?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com26">            <cite class="fn"><a class="url" rel="external nofollow" href="http://bluetouff.com">bluetouff</a></cite> <span class="says">dit&nbsp;:</span>       </div><!-- .comment-author .vcard -->

<div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/06/la-loi-hadopi-mise-a-mal-par-freewifi/comment-page-1/#comment-26">
30 juin 2009 à 0 h 11 min</a>      </div><!-- .comment-meta .commentmetadata -->

<div class="comment-body"><p><a rel="nofollow" href="#comment-22">@moule</a><br>
Arp Poisonning avec Ettercap par exemple.<br>
Le concept est d’envoyer un faux certificat (très facile de l’accepter quand on a un navigateur de merde comme 65% des internautes et qu’on est un peu distrait comme 99% des internautes) … c’est une technique très efficace et peu de gens font gaffe à voir si le certificat est signé par un tiers de confiance.</p>
</div>

<div class="reply">
</div><!-- .reply -->
</div><!-- #comment-##  -->

</li>
</ol>
</div>
