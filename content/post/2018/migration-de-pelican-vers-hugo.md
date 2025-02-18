---
Draft: False
Date: 2018-03-04
Title: Migration de Pelican vers Hugo
SubTitle: Migration vers un nouveau moteur de blog statique
Section: Informatique
Tags:
- planet-libre
- Blog
- Opensource
Image:
  src: /img/2018/atom-banner.png
  desc: Blog content
Sources:
  - sitename: www.python.org
    link: https://www.python.org/
  - sitename: golang.org
    link: https://golang.org/
  - sitename: gohugo.io
    link: https://gohugo.io/
  - sitename: github.com
    link: https://github.com
  - sitename: staticman.net
    link: https://staticman.net
  - sitename: docutils.sourceforge.net
    link: http://docutils.sourceforge.net/rst.html
  - sitename: daringfireball.net
    link: https://daringfireball.net/projects/markdown/
  - sitename: raw.githubusercontent.com
    link: https://raw.githubusercontent.com
  - sitename: themes.gohugo.io
    link: https://themes.gohugo.io/theme/beautifulhugo/
  - sitename: api.staticman.net
    link: https://api.staticman.net/v2/connect/<USERNAME>/<REPOSITORYNAME>`,
  - sitename: travis-ci.org
    link: https://travis-ci.org/
  - sitename: jamstatic.fr
    link: https://jamstatic.fr/2016/12/09/des-commentaires-statiques-avec-jekyll-et-staticman/
---

Comme vous avez pu le remarquer, je suis assez friand de sites statiques. C'est
pour cette raison que ce blog migre une nouvelle fois vers un nouveau moteur de
blog statique, encore me direz vous ? Nous allons voir pourquoi.

## Pourquoi une nouvelle migration ?

Après avoir fait du [Python](https://www.python.org/) pendant de nombreuses
années, il m'arrive de temps en temps de coder en [Go](https://golang.org/). Ce
langage est relativement simple, performant, et compilable sur de nombreuses
architectures (notamment ARM).

J'en ai donc profité pour analyser les offres de blogs statiques développés en
**Go**. J'ai découvert l'excellent projet nommé [Hugo](https://gohugo.io)

## Les avantages d'**Hugo**

- S'installe facilement, il suffit de copier un binaire. En Python, parfois on
  se retrouve confronté à des problèmes de dépendance (même en utilisant des
  **virtual env**)
- Ultra rapide, il permet de générer environ 1000 pages en 1 seconde
- Multi-langue (i18n)
- Base de données virtuelles (data)
- Raccourci (shortcode)
- Facile d'utilisation, flexible, ...
- Nombreux thèmes
- etc ..

## Etapes de la migration

J'ai profité de cette migration pour effectuer quelques changements, notamment :

- Changer de thème
  ([Voir mes contributions](https://github.com/halogenica/beautifulhugo/pulls?utf8=%E2%9C%93&q=is%3Apr%20author%3Abadele)),
  j'ai préféré contribuer à une nouveau thème que convertir le mien.
- Passer les commentaires en full statique en utilisant le projet
  ([Staticman](https://staticman.net/)), malgrès l'ébauche du projet cacause que
  nous avions initié il y a environ 5 ans avec
  [Nahir Mohamed](https://github.com/nadley) &
  [Yannic Arnoux](https://github.com/kianby)

### 1) Passage de reStructuredText vers Markdown

La première étape a été de migrer le contenu des billets du format
[reStructuredText](http://docutils.sourceforge.net/rst.html) vers
[MarkDown](https://daringfireball.net/projects/markdown/). Etant donné que je
n'avais pas beaucoup de fichiers à convertir (environ une vingtaine). J'ai
effectué la conversion fichier par fichier avec la commande suivante
`pandoc --from=rst --to=markdown --output=monbillet.md` pour ensuite finaliser
la conversion à la main pour lequel l'outil **pandoc** n'a pas réussi la
conversion.

### Compatibilité avec le blog précédent

Afin que la migration soit la plus transparente possible, que ce soit pour les
précédents billets ou les flux RSS. Il a fallu effectuer quelques modifications
sur la configuration par défaut d'**Hugo**

- Création d'alias
  - Cela se configure en utilisant le tag `Aliases` dans les métadonnées d'un
    billet
    ([Voir exemple](https://raw.githubusercontent.com/badele/blog.jesuislibre.org/master/content/post/2009/naissance-dun-geek.md))
- Compatiblité des flux RSS
  - En changeant le
    [format des flux RSS généré](https://github.com/badele/blog.jesuislibre.org/blob/bc3f7d8893e82d2b4eda8f9bf5abf6f9b00b23eb/config.yaml#L24).
  - [Création d'un nouveau template](https://raw.githubusercontent.com/badele/blog.jesuislibre.org/master/layouts/_default/rss.atom)
    pour ne pas avoir des flux RSS tronqués.

#### Alias

**Hugo** permet de créer des `Aliases` pour une page. Je me sers de cette option
pour migrer les URL de mon ancien blog vers les nouvelles. Ceci sans devoir
utiliser la technique de l'URL rewriting des serveurs webs (Apache ou Nginx).

#### Feed RSS

**Hugo** gènère des fichiers RSS avec le format `index.xml`, mes anciens flux
avaient le format `feed.atom`. Pour garder ce format, il faut ajouter au fichier
`config.yaml` les lignes suivantes :

```yaml
# Rename RSS feed
outputs:
  home: ["HTML", "RSS"]
  taxonomy: ["HTML", "RSS"]

mediaTypes:
  "application/rss":
    suffix: "atom"

outputFormats:
  RSS:
    mediatype: "application/rss"
    baseName: "feed"
```

Je ne sais pour quelle raison, **Hugo** ne propose pas d'option pour désactiver
la génération des flux RSS non tronqué, pour cela on est obligé de créer un
[nouveau template](https://raw.githubusercontent.com/badele/blog.jesuislibre.org/master/layouts/_default/rss.atom)
dans le fichier `layouts/_default/rss.atom`

### Migration vers un nouveau thème

Dans un premier temps, j'ai voulu conserver mon thème, mais n'ayant pas touché
des feuilles de style depuis un bon bout de temps, j'ai préféré me rabattre sur
un nouveau thème et de contribuer au projet
[Beautiful Hugo](https://themes.gohugo.io/theme/beautifulhugo/)

J'ai rajouté quelques contributions au thème d'origine:

- Ajout du
  [support de la langue Française](https://github.com/halogenica/beautifulhugo/pull/92)
- Ajout d'une nouvelle feature
  [Image title](https://github.com/halogenica/beautifulhugo/pull/93)
- Modification des feuilles de style pour le
  [support de Chroma](https://github.com/halogenica/beautifulhugo/pull/94)
- Modification des templates pour le support des renommages des
  [flux RSS](https://github.com/halogenica/beautifulhugo/pull/95)
- Ajout du support des
  [commentaires statiques](https://github.com/halogenica/beautifulhugo/pull/99)
- Affichage
  [d'informations supplémentaires concernant un billet](https://github.com/halogenica/beautifulhugo/pull/100)
- [Support piwik](https://github.com/halogenica/beautifulhugo/pull/102)

### Ajout du support des commentaires statiques

Pour cela, j'utilise l'excellent projet [Staticman](https://staticman.net/).
Pour ajouter un commentaire, **staticman** utilise **github** pour effectuer une
**pull request** sur le projet du blog

1. Créer le fichier
   [staticman.yml](https://github.com/badele/blog.jesuislibre.org/blob/master/staticman.yml)
1. Dans [github](http://github.com) ajouter l'utilisateur `staticmanapp` en tant
   que collaborateur de votre blog.
1. Accepter l'invitation de collaboration
   `curl https://api.staticman.net/v2/connect/<USERNAME>/<REPOSITORYNAME>`, Si
   l'invitation est acceptée, vous devriez voir le texte **OK!**

### Vérification du bon déroulement de migration

Afin de vérifier que la migration s'est déroulée sans encombre, j'ai comparé les
noms des fichiers générés entre l'ancien et nouveau contenu.

#### Recupération de l'ancien contenu

```bash
rsync -avr --delete  w4a153382@ssh.web4all.fr:/datas/vol3/w4a153382/var/www/blog.jesuislibre.org/htdocs .
cd htdocs
find . | sort > /tmp/old.txt
```

#### Génération du nouveau contenu

```bash
hugo
cd public
find . | sort > /tmp/new.txt
```

#### Comparaison des fichiers

Pour finir, je me suis assuré via **meld** que le contenu de chaque billet a été
migré sans trop d'incidence.

### Prochaine étapes

Afin d'améliorer la génération du blog, la prochaine étape sera d'ajouter de
l'automatisation via des plugins github, par exemple vérifier avec
[Travis-ci](https://travis-ci.org/) qu'aucune erreur ne se produit lors de
l'ajout d'un commentaire ou d'un nouveau billet.

**Source:**

- [hugo](https://gohugo.io/)
- [staticman](https://staticman.net/docs/)
- [hugo-plus-staticman](https://github.com/eduardoboucas/hugo-plus-staticman)
- [jekyll et staticman](https://jamstatic.fr/2016/12/09/des-commentaires-statiques-avec-jekyll-et-staticman/)

