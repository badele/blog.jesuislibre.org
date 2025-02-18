---
Date: 2012-06-12T00:00:00
Title: Support du CM15a (driver iplc) pour le kernel 3.x
Section: Informatique
Aliases: /2012/6/12/support-du-cm15a-driver-iplc-pour-le-kernel-3x
Tags:
- planet-libre
- Linux
- Archlinux
- Domotique
- Opensource
- X10
Sources:
  - sitename: www.absurde.org
    link: http://www.absurde.org/wp-content/uploads/2011/10/iplc-2.6.36.patch_.txt
  - sitename: www.linuxha.com
    link: http://www.linuxha.com/common/iplcd/iplc-driver.tgz
  - sitename: www.eclipsehomeauto.com
    link: http://www.eclipsehomeauto.com/cm15a_on_linux/cm15ademo.tar.gz
  - sitename: aur.archlinux.org
    link: https://aur.archlinux.org
---

**Edit** : Ayant eu trop de crash avec ce module, je me suis rabattu sur un
CM11a, depuis plus de problème

Je me suis enfin lancé, depuis le temps que j’attendais ça .

Malheureusement l’introduction a été difficile, d’une part pour trouver la
technologie qui corresponde le mieux à mes besoins et d’autre part que celle ci
soit compatible linux.

Comme le CM11 n’est plus fabriqué et qu’il est une ressource rare dans le marché
de l’occasion, Je me suis rabattu sur le CM15a (semble t’il moyennement supporté
avec heyu).

**Le CM15a ça sert à quoi ?**

Il permet de piloter l’ensemble des modules X10 depuis votre PC, il peut
également recevoir ou envoyer (pas supporté sous linux) des ordres via son
récepteur RF

**Compilation du module**

Voici la démarche pour créer le module qui ajoute le support du CM15a sur un
kernel 3.x.

```bash
#!/bin/bash

TMP=/tmp/iplc

# Création repertoire temporaire
mkdir -p $TMP
cd $TMP

# Récupération des sources
wget "http://www.absurde.org/wp-content/uploads/2011/10/iplc-2.6.36.patch_.txt"
wget "http://www.linuxha.com/common/iplcd/iplc-driver.tgz"

# Decompression et patch
tar -xvzf iplc-driver.tgz
patch  iplc/driver/linux-2.6/device.c <  iplc-2.6.36.patch_.txt
sed -i 's#linux/autoconf.h#generated/autoconf.h#'  iplc/driver/linux-2.6/device.c
sed -i 's#\#include <linux/smp_lock.h>#//\#include <linux/smp_lock.h>#' iplc/driver/linux-2.6/device.c

# Compilation
cd iplc/driver/linux-2.6/
make cm15a
```

Nous avons dorénavant un module dans le répertoire cm15a.d/cm15a.ko, nous
pouvons monter le module en faisant insmod cm15a.ko

Exemple de script pour monter automatiquement le module lors du démarrage du
système (modifiez les emplacements suivant votre distribution)

```bash
#!/bin/bash
insmod cm15a.ko
chmod 750 /dev/cm15a0
```

**Test du fonctionnement**

Pour tester le bon fonctionnement du module nous allons compiler un binaire qui
permet de piloter l’allumage ou l’extinction d’une lampe.

```bash
#!/bin/bash
wget "http://www.eclipsehomeauto.com/cm15a_on_linux/cm15ademo.tar.gz"
tar -xvzf cm15ademo.tar.gz
make
cp cm15ademo /usr/bin/
```

Exemple d’utilisation

```bash
#!/bin/bash
cm15ademo a1 on # Allume la lampe de code a1
cm15ademo a2 off # Etteind la lampe de code a2
cm15ademo a1 dim 20 # Diminue la puissance de la lampe a1 de 20 %
cm15ademo a1 bri 20 # Augmente la puissance de la lampe a1 de 20 %
```

Installation sur archlinux

J’ai également créé les paquets
[iplc](https://aur.archlinux.org/packages.php?ID=59998) &
[cm15ademo](https://aur.archlinux.org/packages.php?ID=60002) pour la
distribution archlinux que vous pouvez installer avec la commande suivante

```bash
#!/bin/bash
yaourt -S iplc cm15ademo
```
