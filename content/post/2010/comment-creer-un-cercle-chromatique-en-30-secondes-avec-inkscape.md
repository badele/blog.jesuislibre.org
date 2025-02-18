---
Date: 2010-05-16
Title: Comment créer un cercle chromatique en 30 secondes avec Inkscape
Image:
  src: http://farm4.static.flickr.com/3013/4608319515_a8168a1804_o.png
  desc: Cercle chromatique
Section: Informatique
Aliases: /2010/5/16/comment-creer-un-cercle-chromatique-en-30-secondes-avec-inkscape
Tags:
- planet-libre
- Linux
- Tutoriel
Sources:
  - sitename: fr.wikipedia.org
    link: http://fr.wikipedia.org/wiki/Cercle_chromatique
---

**Introduction** Pour le besoin d’un de mes nouveaux projets web de gestion de
mot de passe (j’aurais l’occasion d’écrire un article plus tard), j’ai été
confronté au choix des couleurs. Pour cela je me suis servi d’Inkscape pour
fabriquer un cercle chromatique que je peux ensuite affiner à mon aise.

**Qu’est-ce un cercle chromatique ?** Un
[cercle chromatique](http://fr.wikipedia.org/wiki/Cercle_chromatique) est une
représentation circulaire des couleurs conventionnelles. Celles-ci sont
ordonnées comme au sein d’un arc-en-ciel, la fermeture du cercle s’effectuant
par une transition du rouge au violet via le magenta.

Un cercle chromatique peut présenter les couleurs sous forme discrètes (parts du
cercle) ou en continu. Il arrive qu’on utilise tout le disque pour présenter les
variantes soit en intensité, soit en saturation des couleurs. [Source:
wikipedia]

**Les éléments** Nous allons donc découper le cercle en 12 parts avec 8
variantes de luminosité. Dans Inkscape, nous aurons besoin des unités suivantes:
pourcentage(100), Degré(360), gestion des couleurs(255), puis nous allons
calculer les intervalles nécessaires au calcul des intervalles de rotation et de
changements de couleur.

- 360/12 = 30
- 100/8 = 12.5
- 100/12 = 8.3

**Conception**

L’astuce pour créer le cercle chromatique est d’utiliser la fonction clone et
pavage d’inkscape.

- Créer un cercle de la taille de votre choix, modifier son barycentre(centre de
  rotation) et lancer la fonction **clone** et **pavage**

![inkscape01](/img/2010/inkscape01.png)

[Translation] Indiquer 8 lignes sur 12 colonnes et les valeurs des translations

![inkscape02](/img/2010/inkscape02.png)

[Dimension] Réglage des échelles

![inkscape03](/img/2010/inkscape03.png)

[Rotation] Angle de rotation

![inkscape04](/img/2010/inkscape04.png)

[Couleur] Couleur de départ et intervalles

{{< youtube TY0V3N4p724 >}}
