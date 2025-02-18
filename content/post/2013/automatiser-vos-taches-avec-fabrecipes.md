---
Date: 2013-03-06
Title: Automatiser vos tâches avec Fabrecipes
Section: Informatique
Aliases: /2013/10/11/automatiser-vos-taches-avec-fabrecipes
Tags:
- planet-libre
- Fabrecipes
- Python
- Linux
Sources:
  - sitename: github.com
    link: https://github.com
  - sitename: docs.fabfile.org
    link: http://docs.fabfile.org/
  - sitename: wiki.archlinux.org
    link: https://wiki.archlinux.org/index.php/ZFS#Unofficial_repository
---

## Le projet

Dernièrement, il m'est arrivé divers incidents sur mon poste de travail
(problèmes matériels), et ce malgré qu'au sein de mon foyer je possède d'autres
postes, il m'a été impossible de basculer sur l'un d'eux de façon rapide( manque
d'outils de développement, manque de données de travail)

J'ai donc décidé de créer l'outil
[fabrecipes](https://github.com/badele/fabrecipes) afin d'automatiser et
simplifier l'installation d'un poste de travail. Pour cela je m'appuie sur
l'excellent [fabtools](https://github.com/ronnix/fabtools) qui lui même repose
sur [fabric](http://docs.fabfile.org/).

## Les besoins

Suite à mes précédents incidents, j'ai donc décidé de travailler ainsi :

1. Automatiser l'installation de mon environnement de travail sur l'ensemble des
   postes au sein de mon foyer en tenant compte des différences matérielles &
   des spécificités de la famille (je travaille exclusivement sous Linux).
2. Travailler en live sur les données.

## Apport de réponse

1. Pour répondre au point 1, j'ai créé la recette
   [fabrecipes](https://github.com/badele/fabrecipes) **archlinux/autoinstall**,
   celle ci permet d'installer de façon automatique une distribution Archlinux
   depuis un LiveCD
2. Pour le point 2, j'ai décidé de travailler directement sur un disque USB
   chiffré + partition ZFS. J'ai créé la recette **archlinux/zfs**. Ceci permet
   de faire des snapshots ainsi que de répliquer à l'identique sur un deuxième
   disque chiffré + ZFS (les snapshots sont également répliqués)

## Exemple de recette

**autoinstall**

Voici un exemple détaillé pour la recette **archlinux/autoinstall**, accompagné
de captures d'écrans et vidéo (I3 sur couche XFCE)

<img src="/img/2013/2013-06-23-154417_1280x800_scrot.png" alt="X-Windows choser" width="50%" />

<img src="/img/2013/2013-06-23-154812_1280x800_scrot.png" alt="XFCE Desktop" width="50%" />

<img src="/img/2013/2013-06-23-154854_1280x800_scrot.png" alt="I3 Desktop" width="50%" />

{{< youtube Z_Q8vXKB6Ok>}}

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
  - Installation de XFCE + I3 (choix de l'interface X-Window au démarrage) avec
    le support des fonctionnalités de XFCE depuis I3
  - Synchonisation des dotfiles depuis 3 niveaux:
    - Application
    - Profils d'un portable type
    - Utilisateur

Actuellement il existe également d'autres recettes :

**Emacs**

Installation d'emacs sous un environnement virtualisé python (pour l'utilisation
des composants comme pyflake)

- Installation de l'environnement virtuel python2
- Installation des packages nécessaires pour l'utilisation de emacs avec le
  support de python ( el-get, magit, auto-complete, yasnippet, rope, ropemode,
  ropemacs, flymake, flymake-cursor, python-pep8, nxhtml, color-theme,
  color-theme-solarized, graphviz-dot-mode, pkgbuild-mode, smex, projectile)

**ZFS**

Installation du support du système de fichier ZFS sur Archlinux

- Installation du support de ZFS depuis le projet
  [archzfs](https://wiki.archlinux.org/index.php/ZFS#Unofficial_repository)
- Mise à disposition des outils pour sauvegarder et repliquer son environnement
  de travail.

**Liste complète des fonctionalités**

N'hésitez donc pas à essayer [fabrecipes](https://github.com/badele/fabrecipes)
et d'apporter vos contributions sur
[github](https://github.com/badele/fabrecipes) :)
