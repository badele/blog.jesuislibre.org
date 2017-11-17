---
Date: 2013-02-19
Title: Test unitaire automatisé lors d’un push sur github
SubTitle: Test unitaire automatique.
Image: "/img/2013/travis.png"
Section: Informatique
Aliases: /2013/2/19/test-unitaire-automatise-lors-dun-push-sur-github
Tags:
- planet-libre
- Python
- Github
- Programmation
---


![travis](/img/2013/travis.png)

Suite au développement de
[garchdeps](http://bruno.adele.im/projets/garchdeps/) (outils de gestion
des dépendances pour Archlinux). J’ai rencontré des problèmes lors de
l’accès à certaines propriétés de mon code Python, je n’utilisais pas
les nouvelles méthodes de [création de
classe](http://docs.python.org/2/glossary.html#term-new-style-class).
C’est pour cela que je me suis mis à la recherche d’une solution
permettant d’effectuer des tests unitaires automatiques après chaque
push sur le dépot [github](http://www.github.com/badele), Pratique en
travail d’équipe, cela permet de s’assurer que le code est toujours
valide lorsqu’un membre pushe son code.

Pour cela, je vais utiliser le projet communautaire www.travis-ci.org
couplé à [github](http://www.github.com/badele)

Travis-CI c’est quoi ?
----------------------

Travis-CI est une plateforme d’intégration continue, créée par la
communauté Ruby, cette plateforme est libre et comme le dit la dévise du
projet:

> A distributed build system for the open source community

Cette plateforme est principalement dédiée à la communauté du libre,
d’ailleurs dans sa version communautaire, elle ne prend en compte que
les dépôts github publics. Actuellement travis-ci gère une [quinzaine de
langages](http://about.travis-ci.org/docs/#Specific-Language-Help).

A noter que les sources travis-ci sont disponibles sur le dépôt
[github](https://github.com/travis-ci/travis-ci)

Synchronisation entre travis et github
--------------------------------------

Pour créer un compte sur travis-CI, rien de plus simple, il suffit de
cliquer sur « sign in with github », une fois que vous vous êtes
connecté, sélectionnez les dépôts sur lesquels vous désirez effectuer
des tests unitaires

Configuration de votre projet pour supporter le test unitaire (Python)
----------------------------------------------------------------------

A la racine de votre projet, créez le fichier **.travis.yml** contenant
au minimum les lignes suivantes

{{< highlight yaml>}}
# Language à parser
language: python

# Version de python à tester
python:
- "2.7"
- "3.2"

# script du test unitaire à executer
script: ./garchdeps.py --test
{{< /highlight>}}

Exemple d’un code de test unitaire

{{< highlight python>}}
class TestPackages(unittest.TestCase):
 def setUp(self):
     """Before unittest"""
     pwd = os.path.dirname(__file__)
     filename = "%s/%s" % (pwd, "packages.cache")
     self.__allpackages = loadPkgInfo(filename, False, True)

 def test_summary(self):
     """ test summary properties"""
     self.assertEqual(len(self.__allpackages), 1277)
     self.assertEqual(self.__allpackages.fullsize, 6347736)

 def test_size(self):
     """ test object size"""
     self.assertEqual(self.__allpackages.getPkgByName('libreoffice-common').size, 241767)
     self.assertEqual(self.__allpackages.getPkgByName('kdebase-workspace').size, 73720)
     self.assertEqual(self.__allpackages.getPkgByName('arduino').size, 47104)

 def test_maxiobject(self):
     self.assertEqual(self.__allpackages.maxi['size'].pkgname,
                      'libreoffice-common')
     self.assertEqual(self.__allpackages.maxi['depssize'].pkgname,
                      'kdeplasma-applets-networkmanagement')
     self.assertEqual(self.__allpackages.maxi['nbused'].pkgname,
                      'glibc')
     self.assertEqual(self.__allpackages.maxi['nbtotaldeps'].pkgname,
                      'kdeplasma-applets-networkmanagement')
     self.assertEqual(self.__allpackages.maxi['maxdepth'].pkgname,
                      'kdeutils-kremotecontrol')

 def test_maxivalue(self):
     self.assertEqual(self.__allpackages.maxi['size'].size,
                      241767.0)
     self.assertEqual(self.__allpackages.maxi['depssize'].depssize,
                      1472500.0)
     self.assertEqual(self.__allpackages.maxi['nbused'].nbused,
                      165)
     self.assertEqual(self.__allpackages.maxi['nbtotaldeps'].nbtotaldeps,
                      292)
     self.assertEqual(self.__allpackages.maxi['maxdepth'].maxdepth,
                      16)
{{< /highlight>}}


Push du code vers github
------------------------

Après avoir commité et pushé le code vers github, et après une attente
de quelques secondes, le résultat de votre build devrait apparaître sur
le site travis-ci et devrait ressembler à la capture ci-dessous

![travis ci](/img/2013/travis-ci.png)

Bonus
-----

Sur la page README.md de votre projet (github) il est possible d’ajouter
un bouton qui permet d’indiquer si les tests se sont correctement
déroulés. Il vous suffit d’ajouter la ligne suivante

{{< highlight markdown>}}
[![Build Status](https://secure.travis-ci.org/badele/garchdeps.png)](http://travis-ci.org/badele/garchdeps)
{{< /highlight>}}

Ce qui donne ceci

![garchdeps](https://secure.travis-ci.org/badele/garchdeps.png)
