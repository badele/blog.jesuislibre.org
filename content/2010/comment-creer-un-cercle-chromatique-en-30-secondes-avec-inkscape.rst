Comment créer un cercle chromatique en 30 secondes avec Inkscape
################################################################
:date: 2010-05-16
:tags: Cercle chromatique, Linux, Inkscape, planet-libre, Color, Tutoriel, Tutorial
:summary: J’ai été confronté au choix des couleurs. Pour cela je me suis servi d’Inkscape pour fabriquer un cercle chromatique que je peux ensuite affiner à mon aise.

.. image:: http://farm4.static.flickr.com/3013/4608319515_a8168a1804_o.png
   :width: 100%
   :alt: totocercle chromatique 

**Introduction**
Pour le besoin d’un de mes nouveaux projets web de gestion de mot de passe (j’aurais l’occasion d’écrire un article plus tard), j’ai été confronté au choix des couleurs. Pour cela je me suis servi d’Inkscape pour fabriquer un cercle chromatique que je peux ensuite affiner à mon aise.


**Qu’est-ce un cercle chromatique ?**
Un `cercle chromatique <http://fr.wikipedia.org/wiki/Cercle_chromatique>`_ est une représentation circulaire des couleurs conventionnelles. Celles-ci sont ordonnées comme au sein d’un arc-en-ciel, la fermeture du cercle s’effectuant par une transition du rouge au violet via le magenta.

Un cercle chromatique peut présenter les couleurs sous forme discrètes (parts du cercle) ou en continu. Il arrive qu’on utilise tout le disque pour présenter les variantes soit en intensité, soit en saturation des couleurs. [Source: wikipedia]


**Les éléments**
Nous allons donc découper le cercle en 12 parts avec 8 variantes de luminosité. Dans Inkscape, nous aurons besoin des unités suivantes: pourcentage(100), Degré(360), gestion des couleurs(255), puis nous allons calculer les intervalles nécessaires au calcul des intervalles de rotation et de changements de couleur.

- 360/12 = 30
- 100 / 8 = 12.5
- 100 /12 = 8.3


**Conception**

L’astuce pour créer le cercle chromatique est d’utiliser la fonction clone et pavage d’inkscape.

- Créer un cercle de la taille de votre choix, modifier son barycentre(centre de rotation) et lancer la fonction **clone** et **pavage**

.. image:: /static/inkscape01.png
   :width: 50%
   :alt: inkscape01

[Translation] Indiquer 8 lignes sur 12 colonnes et les valeurs des translations

.. image:: /static/inkscape02.png
   :width: 50%
   :alt: inkscape02

[Dimension] Réglage des échelles

.. image:: /static/inkscape03.png
   :width: 50%
   :alt: inkscape03

[Rotation] Angle de rotation

.. image:: /static/inkscape04.png
   :width: 50%
   :alt: inkscape04

[Couleur] Couleur de départ et intervalles

.. raw:: html

         <object width="425" height="344" type="application/x-shockwave-flash" data="http://www.youtube.com/v/TY0V3N4p724&amp;#038;rel=0&amp;#038;fs=1&amp;#038;showsearch=0&amp;#038;showinfo=0" id="vvq-604-youtube-1" style="visibility: visible;"><param name="wmode" value="opaque"><param name="allowfullscreen" value="true"><param name="allowscriptaccess" value="always"></object>

         <div id="comments">


		 <h3 id="comments-title">2 réponses à <em>Comment créer un cercle chromatique en 30 secondes avec Inkscape</em></h3>


		 <ol class="commentlist">
		 <li id="li-comment-239" class="comment even thread-even depth-1">
		 <div id="comment-239">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/4ed06b1f0fc89e609ba21fbd185101a9?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com239">			<cite class="fn">Anne-laure</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2010/05/comment-creer-un-cercle-chromatique-en-30-secondes-avec-inkscape/comment-page-1/#comment-239">
		 4 novembre 2011 à 13 h 16 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Merci pour les informations afin de créer le cercle chromatique. Par contre, il y a un décalage des couleurs. Comment faire pour que le cercle soit exacte. C’est à dire que les couleurs complémentaires doivent être en face : bleu/orange, rouge/vert, … Or avec ce cercle ce n’est pas le cas!<br>
         Merci d’avance</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-483" class="comment odd alt thread-odd thread-alt depth-1">
		 <div id="comment-483">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/c975057def8372a6687d5dbe86c8f7b9?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="com483">			<cite class="fn"><a class="url" rel="external nofollow" href="http://mora.blog4ever.com">chantalM</a></cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2010/05/comment-creer-un-cercle-chromatique-en-30-secondes-avec-inkscape/comment-page-1/#comment-483">
		 14 septembre 2012 à 10 h 56 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>super ces infos !!!!</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
		 </ol>
         </div>
