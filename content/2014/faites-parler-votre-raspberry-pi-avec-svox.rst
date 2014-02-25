Faites parler votre Raspberry PI avec svox
##########################################
:date: 2014-02-25
:tags: planet-libre, Raspberry, Domotique
:summary: Détaille comment utiliser la synthèse vocale sur un Raspberry PI

Dans le cadre de mon projet domotique `serialkiller`_, j'ai créé un module qui permet de dicter vocalement certains états de mes capteurs. Comme par exemple lors d'un changement de température extérieure.

Pour avoir le support de la synthèse vocale sur Raspberry PI, le moyen le plus simpe que j'ai trouvé, c'est d'utiliser la version Archlinux. Celle-ci permet en quelques lignes de commandes d'avoir un système opérationnel. Voici 2 exemples de fichiers audios générés via svox `heure`_ et `temp`_ (voir les commandes au bas de ce billet)


Installation de Archlinux ARM sur la carte SD
=============================================

.. sourcecode:: bash
   
   cd /tmp
   wget "http://archlinuxarm.org/os/ArchLinuxARM-rpi-latest.zip"
   7z x ArchLinuxARM-rpi-latest.zip 
   dd bs=1M if=ArchLinuxARM*.img of=/dev/mmcblk0
   sync
   Insérer la carte sur le raspberry PI et il vous suffit de booter dessus en allumant le raspberry PI

Configuration & Optimisation
----------------------------

Connecter votre Raspberry sur le réseau et se connecter avec le login **root** et password **root**. Les optimisations suivantes permettent de réduire l'écriture sur la carte SD

.. sourcecode:: bash

   echo "/dev/root  /  ext4  noatime,discard  0  0" >> /etc/fstab
   echo "tmpfs   /var/log        tmpfs   nodev,nosuid,size=16M   0       0" >> /etc/fstab
   rm -R /var/log
   ln -sf /dev/null ~/.bash_history

Installation de yaourt & upgrade
--------------------------------

.. sourcecode:: bash

   pacman -S yaourt
   yaourt -Syua


Installation de svox
--------------------

.. sourcecode:: bash

   yaourt -S base-devel svox-pico-git

Exemples d'utilisation
----------------------

.. sourcecode:: bash

   pico2wave -l fr-FR -w /tmp/heure.wav "Bonjour cher linuxien, Il est 20h53" ; aplay /tmp/heure.wav 
   
Résultat : `heure`_ 

.. sourcecode:: bash

   pico2wave -l fr-FR -w /tmp/temp.wav "Il fait une température extérieure de : 15°" ; aplay /tmp/temp.wav

Résultat : `temp`_ 

.. _serialkiller: https://github.com/badele/serialkiller
.. _heure: /static/tts/heure.wav
.. _temp: /static/tts/temp.wav
