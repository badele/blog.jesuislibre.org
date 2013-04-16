public: yes
tags: [ Github, planet-libre, Python, Git ]
summary: |
  Script qui permet de vérifier vos dépôts git en une seule passe. Affiche un résumé de l'état de vos projets.

Vérifiez vos dépôts git en une seule passe.
===========================================

Ne vous est-il pas arrivé de travailler sur plusieurs projets à la fois ? C'est mon cas, de plus je switche assez souvent d'un projet à l'autre. A la longue on ne s'y retrouve plus, on ne sait plus quels sont les projets en cours non commités.

J'ai donc créé un script qui permet de vérifier en une seule passe quels sont les projets ayant subit des modifications et devant etre commités. Ce script parcourt les répertoires et sous-répertoires à la recherche des dépôts git.

Utilisation
-----------

**Commande**

Pour l'utiliser, rien de plus simple

.. sourcecode:: bash

   cd /usr/local/bin
   wget https://raw.github.com/badele/gitcheck/master/gitcheck.py
   chmod 755 gitcheck.py
   gitcheck.py
   ou
   gitcheck.py -v

**Version simplifiée**

Exemple d'utilisation en version simple.


.. image:: /static/gitcheck.png
   :width: 75%

Cette version affiche l'ensemble de vos dépôts git avec une mise en évidence de l'état du projet, en vert les dépôts git non modifiés, en rose les dépôts git modifiés.

**Version verbale**

.. image:: /static/gitcheck_verbose.png
   :width: 75%

La version verbose, indique en sus de la version précédente les fichiers modifiés en orange.

**Les sources**

Les sources du script sont disponibles sur le dépot github https://github.com/badele/gitcheck
