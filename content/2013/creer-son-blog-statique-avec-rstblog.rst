Créer son blog statique avec rstblog
####################################
:date: 2013-03-06
:tags: Github, planet-libre, Python, Blog, Statique, Migration
:summary: Après plusieurs recherches, je pense avoir trouvé mon moteur de blog, il se nomme rstblog. Créé par Armin Ronacher, auteur également de `Flask <http://flask.pocoo.org>`_

**Edit**
J'ai migré dorénavant ce blog vers `Pelican`_

Après plusieurs recherches, je pense avoir trouvé mon moteur de blog, il se nomme `rstblog`_, créé par `Armin Ronacher`_, également auteur de `Flask`_. Auparavant pour certains de mes autres sites,  j'utilisais un CMS+Blog statique qui se nommait `GetSimple`_. Mais allez savoir pourquoi, malgré la qualité de cette application web, je n'ai pas accroché ! Pendant mes recherches sur une alternative à Django, je suis tombé sur l'auteur de `Flask`_ qui a lui-même conçu son blog avec rstblog (normal me direz vous, il en est l'auteur :) )

rstblog c'est quoi
------------------

rstblog est un blog statique qui utilise la syntaxe rst (`reStructuredText <http://docutils.sourceforge.net/docs/user/rst/quickref.html>`_), celle-ci est sensiblement identique aux syntaxes wiki. Pourquoi avoir choisi rstblog ? Les raisons sont les suivantes :

- Sa simplicité et sa légèreté, on ne peut plus simple. L'écriture des billets se fait avec un simple éditeur de texte, pour ma part j'utilise emacs.
- Du full statique, pas de code exécuté sur le serveur (contrairement à `GetSimple`_).
- Le générateur est en Python, ça tombe bien, j'aime ce langage :)
- Couplé avec git on peut d'une part historiser l'évolution du blog, mais également s'en servir comme outil de sauvegarde.


Installation
------------

Afin d'éviter d'avoir des conflits avec des scripts python, j'ai pris l'habitude de créer un environnement virtuel, je vais donc créer un espace virtuel dédié pour rstblog

.. sourcecode:: bash

   mkvirtualenv --no-site-packages -p python2.7 rstblog
   pip install pyyaml babel blinker docutils jinja2 werkzeug pygments 

**Initialisation du blog**

.. sourcecode:: bash

   cd votre_blog
   mkdir -p {static,_templates,2013/3/3}

   wget -O static/style.css "https://raw.github.com/badele/blog.jesuislibre.org/master/static/style.css"
   wget -O _template/layout.html "https://raw.github.com/badele/blog.jesuislibre.org/master/_templates/layout.html"

nano config.yml

.. sourcecode:: yaml

   active_modules: [pygments, tags, blog]
   author: Bruno Adele 
   canonical_url: http://blog.jesuislibre.org/
   feed:
     name: Famille de geeks   
     subtitle: Une famille complètement geek
   modules:   
     pygments:
       style: tango


Je crée ensuite une arborescence qui devrait ressembler au schéma ci-dessous.

.. sourcecode:: text

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


Pour faciliter mes tâches répétitives, notamment le commit sur `github`_ ainsi que l'upload sur le serveur., je crée donc un Makefile.

.. sourcecode:: makefile

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



Votre installation est maintenant terminée, il ne vous reste plus qu'à créer vos billets, comme cité plus haut, pour cela, j'utilise le couple  Emacs + rest mode

.. image:: /static/emacs_rst_mode.png
   :width: 100%
   :alt: rstmode for emacs

Exemple de process pour la publication d'un billet.

.. sourcecode:: bash

   cd votre_blog
   workon rstblog
   emacs 2013/3/3/votre_billet
   make build serve # Pour tester votre blog avant publication sur localhost:5000
   git commit
   make clean build upload push # Pour upload sur votre serveur ainsi que sur github

En espérant que cela donnera aux indécis l'envie de passer le cap :)

.. _rstblog: https://github.com/mitsuhiko/rstblog
.. _Armin ronacher: http://lucumr.pocoo.org
.. _flask: http://flask.pocoo.org
.. _getsimple: http://get-simple.info
.. _github: https://github.com/badele/blog.jesuislibre.org
.. _pelican: http://blog.getpelican.com/
