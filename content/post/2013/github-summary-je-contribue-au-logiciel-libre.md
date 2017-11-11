---
Date: 2013-12-20
Title: github-summary, je contribue au logiciel libre
SubTitle: Résumé de vos projets en une seule page
Image: "/img/2013/github-summary.png"
Section: Informatique
Aliases: /2013/12/20/github-summary-je-contribue-au-logiciel-libre
Tags:
- planet-libre
- Github
- Git
- Opensource
---


![github-summary](/img/2013/github-summary.png)

Il m'est arrivé par le passé de contribuer modestement à certains
projets libres dont j'en ai oublié les noms. Auparavant, les projets
étaient dispersés sur les sites des auteurs ou sur des forges comme
[Sourceforge](http://www.sourceforge.net) ou
[Savannah](http://savannah.gnu.org). Habituellement pour participer à un
projet il fallait soit patcher les sources du projet soit être membres
d'un projet.

Puis vint [Github](https://github.com), son point fort est qu'il vous
oblige à forker le projet avant d'effectuer la moindre modification. Au
premier abord, on pourrait penser que trop de fork aurait pour
conséquence de tuer le projet initial, mais il n'en est rien !

Grâce à [Git](http://git-scm.com) et [Github](https://github.com) il est
beaucoup plus facile pour moi de contribuer d'avantage au logiciel
libre. La prochaine étape serait d'apporter mon savoir faire dans une
société Opensource.

Revenons à nos moutons :) Pour résumer mes contributions sur la page
principale de mon blog, j'ai créé un outil qui permet de générer sous
divers formats un condensé de mes projets github auxquels j'ai
participés.

Installation
------------

Pour installer `github-summary`, vous avez 2 possibilités:

Soit l'installer depuis
[PyPI](http://pypi.python.org/pypi/github-summary)

{{< highlight bash>}}
pip install github-summary
{{< /highlight>}}

Ou directement depuis le dépot
[GitHub](https://github.com/badele/github-summary) :)

{{< highlight bash>}}
pip install git+git://github.com/badele/github-summary.git
{{< /highlight>}}

Utilisation
-----------

Modifier le fichier de configuration `~/.github-summary.py` ou
`config.py`. Pour des raisons de sécurité je vous conseille de modifier
vos paramètres dans le fichier `~/.github-summary.py` afin d'y stocker
vos identifiants [Github](https://github.com) (token).

Puis il suffit de lancer la commande ci-dessous.

{{< highlight bash>}}
githubsummary -t rst/index-en.rst -j example_projects.json -s example.rst
{{< /highlight>}}

Ceci génèrera une page au format RST (pour le blog
[Pelican](http://blog.getpelican.com/)) en utilisant les options JSON

Options
-------

Vous pouvez apporter des options pour chaque projet, le paramétrage se
fait au format JSON. Pour l'instant, il est possible de modifier les
heures passées sur un projet (grâce à org2json), comme par exemple le
temps passé sur la contribution d'un projet (Pour cela j'utilise
l'excellent [Org mode d'emacs](http://orgmode.org/fr)).

{{< highlight json>}}
{
 "fabrecipes": {
     "hours": "89",
     "description": "A overwriting description text for fabrecipe."
 },
 "JobCatcher": {
     "hours": "108",
     "description": "Another overwriting description text for JobCatcher."
 },
 "gitcheck": {
     "hours": "15",
     "url": "http://bruno.adele.im/projets/gitcheck",
     "description": "Check multiple git repository in one pass."
 },
 "github-summary": {
     "coveralls": "True",
     "description": "Python tool for generate github summary in multiple formats (TXT, RST, HTML, ...)",
     "pypi": "True",
     "pydownload": "True",
     "hours": "30",
     "travis": "True"
 }
}
{{< /highlight>}}

Comme expliqué précédemment, il est possible avant d'appeler
`github-summary` de surcharger le fichier de configuration avec les
heures passées sur un projet, pour cela il suffit d'exécuter la commande
suivante

{{< highlight bash>}}
org2json -o project.org -s example_projects.json
{{< /highlight>}}

Voici un exemple pour la génération d'une page example.rst

{{< highlight bash>}}
githubsummary -t rst/index-en.rst -j example_projects.json -s example.rst
{{< /highlight>}}

Vous pouvez visualiser le résultat sur la capture ci-dessous ou sur [mon
site personnel](http://bruno.adele.im)

![github-summary](/img/2013/github-summary-result.png)
