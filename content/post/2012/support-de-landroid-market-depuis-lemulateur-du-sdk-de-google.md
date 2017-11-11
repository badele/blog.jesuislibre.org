---
Date: 2012-10-22
Title: Support de l’Android Market depuis l’emulateur du SDK de Google
SubTitle: Utiliser Google Play depuis un emulateur Android.
Section: Informatique
Aliases: /2012/10/22/support-de-landroid-market-depuis-lemulateur-du-sdk-de-google
Tags:
- planet-libre
- Linux
- Android
---

![android screen](/img/2012/android-0.png)

Pour ceux qui n’ont pas encore la chance d’avoir un téléphone Android,
ils peuvent tester le système d’exploitation Android grâce au SDK de
Google, puisque celui ci est fourni avec un émulateur de téléphone.

Hélas, l’émulateur fourni avec le SDK ne contient pas les applications
propriétaires de Google comme par exemple GMail,GTalk et bien entendu
l’[Android
Market](http://blog.jesuislibre.org/2009/10/support-de-landroid-market-depuis-lemulateur-du-sdk-de-google/www.android.com/market/).

De ce fait il perd une grande partie de son intérêt, et il n’est même
pas possible de tester les applications de l’[Android
Market](http://blog.jesuislibre.org/2009/10/support-de-landroid-market-depuis-lemulateur-du-sdk-de-google/www.android.com/market/).

Une petite astuce s’impose:

Installation
------------

Installer le SDK de google ensuite Télécharger la version de
développement du HTC Dream
**signed-dream\_devphone\_userdebug-img-150275.zip** depuis l’adresse
suivante <http://developer.htc.com/adp.html>. Déposer le fichier dans
/tmp

L’astuce est de copier les ROMs provenant du kit de développement du HTC
Dream.

{{< highlight bash>}}
unzip -x /tmp/signed-dream_devphone_userdebug-img-150275.zip -d /tmp/android/
cp system.img /usr/local/android-sdk-linux_x86-1.5_r3/add-ons/google_apis-3/images/
cp userdata.img /usr/local/android-sdk-linux_x86-1.5_r3/add-ons/google_apis-3/images/
sudo chmod a+r /usr/local/android-sdk-linux_x86-1.5_r3/add-ons/google_apis-3/images/*.img
{{< /highlight>}}

Préparer un périphérique virtuel

{{< highlight bash>}}
android create avd -t 3 -n virtual_phone
{{< /highlight>}}

Lancer l’émulateur

{{< highlight bash>}}
emulator -avd virtual_phone
{{< /highlight>}}

-   Etape 1 cliquer sur l’écran, pour commencer l’inscription
-   Etape 2 passer l’étape du tutoriel
-   Etape 3,4 Créer ou utiliser un compte google
-   Etape 5 Tester vos applications sur le market.

![android screenshot](/img/2012/android-1.png)

<div id="comments">


<h3 id="comments-title">4 réponses à <em>Support de l’Android Market depuis l’emulateur du SDK de Google</em></h3>


<ol class="commentlist">
<li class="post pingback">
<p>Ping&nbsp;: <a class="url" rel="external nofollow" href="http://blog.jesuislibre.org/2009/10/installation-du-sdk-android-sous-linux/">Famille de geeks » Installation du SDK Android sous linux</a></p>
</li>
<li id="li-comment-34" class="comment even thread-even depth-1">
<div id="comment-34">
<div class="comment-author vcard">
<img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/8bfea1b6486b95ae06ea256a9e2df7e9?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com34">            <cite class="fn"><a class="url" rel="external nofollow" href="http://bepo.fr">nemolivier</a></cite> <span class="says">dit&nbsp;:</span>        </div><!-- .comment-author .vcard -->

<div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/10/support-de-landroid-market-depuis-lemulateur-du-sdk-de-google/comment-page-1/#comment-34">
23 octobre 2009 à 0 h 10 min</a>       </div><!-- .comment-meta .commentmetadata -->

<div class="comment-body"><p>Salut,<br>
Merci pour ce tuto, mais j’ai un peu de mal : je reste «&nbsp;bloqué&nbsp;» sur le logo android pendant très longtemps, je ne suis pas certain que le fait de cliquer partout change grand chose&nbsp;!<br>
Quand finalement android se lance, je suis bloqué &mdash;&nbsp;c’est bête, je sais&nbsp;&mdash;&nbsp;sur «&nbsp;Slide keyboard open to continue&nbsp;». J’ai essayé plein de choses, mais je ne sais pas comment faire ça sur l’émulateur&nbsp;(</p>
</div>

<div class="reply">
</div><!-- .reply -->
</div><!-- #comment-##  -->

</li>
<li id="li-comment-35" class="comment odd alt thread-odd thread-alt depth-1">
<div id="comment-35">
<div class="comment-author vcard">
<img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/8bfea1b6486b95ae06ea256a9e2df7e9?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com35">            <cite class="fn"><a class="url" rel="external nofollow" href="http://bepo.fr">nemolivier</a></cite> <span class="says">dit&nbsp;:</span>        </div><!-- .comment-author .vcard -->

<div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/10/support-de-landroid-market-depuis-lemulateur-du-sdk-de-google/comment-page-1/#comment-35">
23 octobre 2009 à 0 h 27 min</a>       </div><!-- .comment-meta .commentmetadata -->

<div class="comment-body"><p>J’ai trouvé, en faisant un Ctrl+F11, on fait tourner l’appareil (mode paysage  portrait) et ça «&nbsp;ouvre&nbsp;» le clavier&nbsp;!</p>
</div>

<div class="reply">
</div><!-- .reply -->
</div><!-- #comment-##  -->

</li>
<li class="post pingback">
<p>Ping&nbsp;: <a class="url" rel="external nofollow" href="http://identi.ca/notice/12713582">Costalfy (costalfy) 's status on Friday, 23-Oct-09 10:16:18 UTC - Identi.ca</a></p>
</li>
</ol>
</div>
