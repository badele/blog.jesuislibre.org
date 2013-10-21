Automatiser vos tâches avec Fabrecipes
######################################
:date: 2013-10-11
:tags: planet-libre, Fabrecipes, Python, Linux
:summary: Fabrecipes est un projet qui a pour ambition de créer des recettes d'automatisation des tâches. Par exemple aAutomatiser une installation Archlinux depuis le CD d'installation.

Le projet
---------

Dernièrement, il m'est arrivé divers incidents sur mon poste de travail (problèmes matériels), et ce malgré qu'au sein de mon foyer je possède d'autres postes, il m'a été impossible de basculer sur l'un d'eux de façon rapide( manque d'outils de développement, manque de données de travail)

J'ai donc décidé de créer l'outil fabrecipes_ afin d'automatiser et simplifier l'installation d'un poste de travail. Pour cela je m'appuie sur l'excellent fabtools_ qui lui même repose sur fabric_.

Les besoins
-----------

Suite à mes précédents incidents, j'ai donc décidé de travailler ainsi :

1. Automatiser l'installation de mon environnement de travail sur l'ensemble des postes au sein de mon foyer en tenant compte des différences matérielles & des spécificités de la famille (je travaille exclusivement sous Linux).

2. Travailler en live sur les données.

Apport de réponse
-----------------

1. Pour répondre au point 1, j'ai créé la recette fabrecipes_ **archlinux/autoinstall**, celle ci permet d'installer de façon automatique une distribution Archlinux depuis un LiveCD

2. Pour le point 2, j'ai décidé de travailler directement sur un disque USB chiffré + partition ZFS. J'ai créé la recette **archlinux/zfs**. Ceci permet de faire des snapshots ainsi que de répliquer à l'identique sur un deuxième disque chiffré + ZFS (les snapshots sont également répliqués)

Exemple de recette
------------------

**autoinstall**

Voici un exemple détaillé pour la recette **archlinux/autoinstall**, accompagné de captures d'écrans et vidéo (I3 sur couche XFCE)

.. image:: /static/2013-06-23-154417_1280x800_scrot.png
   :width: 25%
   :alt: X-Windows choser
   :target: /static/2013-06-23-154417_1280x800_scrot.png

.. image:: /static/2013-06-23-154812_1280x800_scrot.png
   :width: 25%
   :alt: XFCE Desktop
   :target: /static/2013-06-23-154812_1280x800_scrot.png

.. image:: /static/2013-06-23-154854_1280x800_scrot.png
   :width: 25%
   :alt: I3 Desktop
   :target: /static/2013-06-23-154854_1280x800_scrot.png

.. raw:: html

   <iframe width="640" height="360" src="//www.youtube.com/embed/Z_Q8vXKB6Ok" frameborder="0" allowfullscreen></iframe>

La recette autoinstall permet d'exécuter les tâches suivantes :

- Installation

  - Prépare & formate les partitions
  - Chiffre la partition /home
  - Installe le système de base
  - Installe le boot

- Configuration (depuis une configuration de poste de travail computer.xxx)

  - Définition du hostname
  - Ajout d'un utilisateur
  - Définition de la disposition du clavier, locale, timezone
  - Configuration du package manager Yaourt
  - Vérification des paquets du système de base

    - zsh
    - yaourt
    - wget
    - git
    - rsync
    - sudo
    - net-tools
    - python2
    - virtualenv
    - virtualenvwrapper

- Installation bonus

  - Installation de votre système de base
  - Installation de XFCE + I3 (choix de l'interface X-Window au démarrage) avec le support des fonctionnalités de XFCE depuis I3
  - Synchonisation des dotfiles depuis 3 niveaux:

    - Application
    - Profils d'un portable type
    - Utilisateur


Actuellement il existe également d'autres recettes :

**Emacs**

Installation d'emacs sous un environnement virtualisé python (pour l'utilisation des composants comme pyflake)

- Installation de l'environnement virtuel python2
- Installation des packages nécessaires pour l'utilisation de emacs avec le support de python ( el-get, magit, auto-complete, yasnippet, rope, ropemode, ropemacs, flymake, flymake-cursor, python-pep8, nxhtml, color-theme, color-theme-solarized, graphviz-dot-mode, pkgbuild-mode, smex, projectile)

**ZFS**

Installation du support du système de fichier ZFS sur Archlinux

- Installation du support de ZFS depuis le projet archzfs_
- Mise à disposition des outils pour sauvegarder et repliquer son environnement de travail.

**Liste complète des fonctionalités**

.. sourcecode:: plaintext

   fab -l
   Available commands:

   archlinux.autoinstall.configure         Configure archlinux fresh installation
   archlinux.autoinstall.env_base          Install base system
   archlinux.autoinstall.env_xorg          Install base Xorg system
   archlinux.autoinstall.env_xorg_misc     Full Xorg installation
   archlinux.autoinstall.env_xorg_xfce_i3  Install Xorg Xfce + I3 feature
   archlinux.autoinstall.install           Install archlinux in a new computer
   archlinux.emacs.install_p2k             Install emacs with some features in python 2.7 environement
   archlinux.pelican.install               Install a pelican in python2 virtualenv
   archlinux.rstblog.install               Install a rstblog in python2 virtualenv
   archlinux.virtualbox.install            Install virtualbox and use dkms virtual host modules
   archlinux.wine.install                  Install wine with customization
   archlinux.zfs.bk_replicates             Replicate snapshot to another pool (default: BACKUP)
   archlinux.zfs.bk_snapshots              Create a today snapshot for the pool (default: LIVE)
   archlinux.zfs.init_crypted_zfs          Prepare a crypted ZFS disk
   archlinux.zfs.install                   Install zfs system (kernel + utils) from archzfs (demizerone repository)
   computer.acer_inspireone                Acer Aspire One netbook
   computer.hp_pavilion_g7                 HP Pavilion g7 Notebook PC
   computer.jsl_acer_inspireone_fix        Fix for Acer Aspire One netbook
   computer.vaio_vgn_ns21s                 Sony Vaio VGN-NS21S netbook
   computer.virtualbox                     Sample computer configuration
                

N'hésitez donc pas à essayer fabrecipes_ et d'apporter vos contributions sur github_ :)

.. _fabrecipes: https://github.com/badele/fabrecipes
.. _fabtools: https://github.com/ronnix/fabtools
.. _fabric: http://docs.fabfile.org/ 
.. _github: https://github.com/badele/fabrecipes
.. _archzfs: https://wiki.archlinux.org/index.php/ZFS#Unofficial_repository
