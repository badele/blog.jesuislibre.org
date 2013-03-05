public: yes
tags: [ Github, planet-libre, Python, Test Unitaire, Travis-CI, Programmation ]
summary: |
  Suite au développement de garchdeps (outils de gestion des dépendances pour Archlinux). J’ai rencontré des problèmes lors de l’accès à certaines propriétés de mon code Python, je n’utilisais pas les nouvelles méthodes de création de classe. C’est pour cela que je me suis mis à la recherche d’une solution permettant d’effectuer des tests unitaires automatiques après chaque push sur le dépot github

Test unitaire automatisé lors d’un push sur github
==================================================

\ 

.. image:: /static/travis.png
   :width: 100%

Suite au développement de `garchdeps`_ (outils de gestion des dépendances pour Archlinux). J’ai rencontré des problèmes lors de l’accès à certaines propriétés de mon code Python, je n’utilisais pas les nouvelles méthodes de `création de classe <http://docs.python.org/2/glossary.html#term-new-style-class>`_. C’est pour cela que je me suis mis à la recherche d’une solution permettant d’effectuer des tests unitaires automatiques après chaque push sur le dépot `github`_,  Pratique en travail d’équipe, cela permet de s’assurer que le code est toujours valide lorsqu’un membre pushe son code.

Pour cela, je vais utiliser le projet communautaire www.travis-ci.org couplé à `github`_

Travis-CI c’est quoi ?
----------------------

Travis-CI est une plateforme d’intégration continue, créée par la communauté Ruby, cette plateforme est libre et comme le dit la dévise du projet::

  A distributed build system for the open source community

Cette plateforme est principalement dédiée à la communauté du libre, d’ailleurs dans sa version communautaire, elle ne prend en compte que les dépôts github publics. Actuellement travis-ci gère une `quinzaine de langages <http://about.travis-ci.org/docs/#Specific-Language-Help>`_.

A noter que les sources travis-ci sont disponibles sur le dépôt `github <https://github.com/travis-ci/travis-ci>`__

Synchronisation entre travis et github
--------------------------------------

Pour créer un compte sur travis-CI, rien de plus simple, il suffit de cliquer sur « sign in with github », une fois que vous vous êtes connecté, sélectionnez les dépôts sur lesquels vous désirez effectuer des tests unitaires

Configuration de votre projet pour supporter le test unitaire (Python)
----------------------------------------------------------------------

A la racine de votre projet, créez le fichier **.travis.yml** contenant au minimum les lignes suivantes

.. sourcecode:: yaml

   # Language à parser
   language: python

   # Version de python à tester
   python:
   - "2.7"
   - "3.2"

   # script du test unitaire à executer
   script: ./garchdeps.py --test

Exemple d’un code de test unitaire

.. sourcecode:: python

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

Push du code vers github
------------------------

Après avoir commité et pushé le code vers github, et après une attente de quelques secondes, le résultat de votre build devrait apparaître sur le site travis-ci et devrait ressembler à la capture ci-dessous

.. image:: /static/travis-ci.png
   :width: 100%

Bonus
-----

Sur la page README.md de votre projet (github) il est possible d’ajouter un bouton qui permet d’indiquer si les tests se sont correctement déroulés. Il vous suffit d’ajouter la ligne suivante

.. sourcecode:: rst

   [![Build Status](https://secure.travis-ci.org/badele/garchdeps.png)](http://travis-ci.org/badele/garchdeps)

Ce qui donne ceci

.. image:: https://secure.travis-ci.org/badele/garchdeps.png


.. raw:: html

         <div id="comments">


         <h3 id="comments-title">2 réponses à <em>Test unitaire automatisé lors d’un push sur github</em></h3>


         <ol class="commentlist">
         <li id="li-comment-592" class="comment even thread-even depth-1">
         <div id="comment-592">
         <div class="comment-author vcard">
         <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/3b355018dfa5b7f363f6c9838a681d82?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn"><a class="url" rel="external nofollow" href="http://ccoste.fr">Charlycoste</a></cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->

         <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2013/02/test-unitaire-automatise-lors-dun-push-sur-github/comment-page-1/#comment-592">
         19 février 2013 à 15 h 50 min</a>		</div><!-- .comment-meta .commentmetadata -->

         <div class="comment-body"><p>Je me permets juste un petit commentaire car tu as omis de préciser que Travis-CI est un logiciel libre sous licence MIT =&gt; <a rel="nofollow" href="https://github.com/travis-ci/travis-core/blob/master/LICENSE">https://github.com/travis-ci/travis-core/blob/master/LICENSE</a></p>
         <p>Ce qui le rend d’autant plus intéressant selon moi… <img class="wp-smiley" alt=":D" src="http://blog.jesuislibre.org/wp-includes/images/smilies/icon_biggrin.gif"> </p>
         </div>

         <div class="reply">
         </div><!-- .reply -->
         </div><!-- #comment-##  -->

         </li>
         <li id="li-comment-600" class="comment odd alt thread-odd thread-alt depth-1">
         <div id="comment-600">
         <div class="comment-author vcard">
         <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/502f55b818f01ac589d5708616e6bfd8?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn"><a class="url" rel="external nofollow" href="http://www.sciunto.org">François</a></cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->

         <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2013/02/test-unitaire-automatise-lors-dun-push-sur-github/comment-page-1/#comment-600">
         22 février 2013 à 21 h 48 min</a>		</div><!-- .comment-meta .commentmetadata -->

         <div class="comment-body"><p>Merci. Je me posais des questions sur Travis et tu y reponds. C’est sympa.</p>
         </div>

         <div class="reply">
         </div><!-- .reply -->
         </div><!-- #comment-##  -->

         </li>
         </ol>
         </div>

.. _garchdeps: http://bruno.adele.im/projets/garchdeps/
.. _github: http://www.github.com/badele

