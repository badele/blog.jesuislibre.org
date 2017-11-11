---
Date: 2013-03-06
Title: Créer son blog statique avec rstblog
Section: Informatique
Aliases: /2013/3/6/creer-son-blog-statique-avec-rstblog
Tags:
- planet-libre
- Github
- Python
- Blog
- Stastique
---

**Edit** J'ai migré dorénavant ce blog vers ~~[Pelican](http://blog.getpelican.com/)~~ [Hugo](http://blog.getpelican.com/)

Après plusieurs recherches, je pense avoir trouvé mon moteur de blog, il
se nomme [rstblog](https://github.com/mitsuhiko/rstblog), créé par
[Armin Ronacher](http://lucumr.pocoo.org), également auteur de
[Flask](http://flask.pocoo.org). Auparavant pour certains de mes autres
sites, j'utilisais un CMS+Blog statique qui se nommait
[GetSimple](http://get-simple.info). Mais allez savoir pourquoi, malgré
la qualité de cette application web, je n'ai pas accroché ! Pendant mes
recherches sur une alternative à Django, je suis tombé sur l'auteur de
[Flask](http://flask.pocoo.org) qui a lui-même conçu son blog avec
rstblog (normal me direz vous, il en est l'auteur :) )

rstblog c'est quoi
------------------

rstblog est un blog statique qui utilise la syntaxe rst
([reStructuredText](http://docutils.sourceforge.net/docs/user/rst/quickref.html)),
celle-ci est sensiblement identique aux syntaxes wiki. Pourquoi avoir
choisi rstblog ? Les raisons sont les suivantes :

-   Sa simplicité et sa légèreté, on ne peut plus simple. L'écriture des
    billets se fait avec un simple éditeur de texte, pour ma part
    j'utilise emacs.
-   Du full statique, pas de code exécuté sur le serveur (contrairement
    à [GetSimple](http://get-simple.info)).
-   Le générateur est en Python, ça tombe bien, j'aime ce langage :)
-   Couplé avec git on peut d'une part historiser l'évolution du blog,
    mais également s'en servir comme outil de sauvegarde.

Installation
------------

Afin d'éviter d'avoir des conflits avec des scripts python, j'ai pris
l'habitude de créer un environnement virtuel, je vais donc créer un
espace virtuel dédié pour rstblog

{{< highlight bash>}}
mkvirtualenv --no-site-packages -p python2.7 rstblog
pip install pyyaml babel blinker docutils jinja2 werkzeug pygments
{{< /highlight>}}

**Initialisation du blog**

{{< highlight bash>}}
cd votre_blog
mkdir -p {static,_templates,2013/3/3}

wget -O static/style.css "https://raw.github.com/badele/blog.jesuislibre.org/master/img/2013/style.css"
wget -O _template/layout.html "https://raw.github.com/badele/blog.jesuislibre.org/master/_templates/layout.html"
{{< /highlight>}}


nano config.yml

{{< highlight yaml>}}
active_modules: [pygments, tags, blog]
author: Bruno Adele
canonical_url: http://blog.jesuislibre.org/
feed:
  name: Famille de geeks
  subtitle: Une famille complètement geek
modules:
  pygments:
    style: tango
{{< /highlight>}}

Je crée ensuite une arborescence qui devrait ressembler au schéma
ci-dessous.

{{< highlight plaintext>}}
blog.jesuislibre.org
├── 2013
│   ├── 2
│       ├── 19
│       │    ├── test-unitaire-automatise-lors-dun-push-sur-github.rst
│       │
│       └── 26
│            ├── decouverte-de-lenvironnement-arduino.rst
├── 2009
│   ├── 5
│       ├── 20
│            ├── naissance-dun-geek.rst
│            ├── export-vos-donnees-de-kphotoalbum-vers-iptc.rst
│            ├── generer-un-schema-xsd-depuis-un-fichier-xml.rst
│
│
├── a-propos.rst
├── config.yml
└── _templates
    └── layout.html
{{< /highlight>}}

Pour faciliter mes tâches répétitives, notamment le commit sur
[github](https://github.com/badele/blog.jesuislibre.org) ainsi que
l'upload sur le serveur., je crée donc un Makefile.

{{< highlight makefile>}}
clean:
  rm -rf _build

build:
      run-rstblog build

serve:
      run-rstblog serve

push:
      git push github master

upload:
      rsync -a _build/ votrecompte@votreserveur:/home/votrerepertoire/
      @echo "Done..."
{{< /highlight>}}

Votre installation est maintenant terminée, il ne vous reste plus qu'à
créer vos billets, comme cité plus haut, pour cela, j'utilise le couple
Emacs + rest mode

<img src="/img/2013/emacs_rst_mode.png" alt="rstmode for emacs" width="75%" />

Exemple de process pour la publication d'un billet.

{{< highlight bash>}}
cd votre_blog
workon rstblog
emacs 2013/3/3/votre_billet
make build serve # Pour tester votre blog avant publication sur localhost:5000
git commit
make clean build upload push # Pour upload sur votre serveur ainsi que sur github
{{< /highlight>}}

En espérant que cela donnera aux indécis l'envie de passer le cap :)
