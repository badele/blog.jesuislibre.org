---
Date: 2012-10-22
Title: Support de l’Android Market depuis l’emulateur du SDK de Google
SubTitle: Utiliser Google Play depuis un emulateur Android.
Section: Informatique
Aliases: /2012/10/22/support-de-landroid-market-depuis-lemulateur-du-sdk-de-google
Tags:
- planet-libre
- Linux
- Android
Sources:
  - sitename: developer.htc.com
    link: http://developer.htc.com/adp.html>.
---

![android screen](/img/2012/android-0_vga_palette_crt_effects.png)

Pour ceux qui n’ont pas encore la chance d’avoir un téléphone Android, ils
peuvent tester le système d’exploitation Android grâce au SDK de Google, puisque
celui ci est fourni avec un émulateur de téléphone.

Hélas, l’émulateur fourni avec le SDK ne contient pas les applications
propriétaires de Google comme par exemple GMail,GTalk et bien entendu
l’[Android Market](http://blog.jesuislibre.org/2009/10/support-de-landroid-market-depuis-lemulateur-du-sdk-de-google/www.android.com/market/).

De ce fait il perd une grande partie de son intérêt, et il n’est même pas
possible de tester les applications de
l’[Android Market](http://blog.jesuislibre.org/2009/10/support-de-landroid-market-depuis-lemulateur-du-sdk-de-google/www.android.com/market/).

Une petite astuce s’impose:

## Installation

Installer le SDK de google ensuite Télécharger la version de développement du
HTC Dream **signed-dream\_devphone\_userdebug-img-150275.zip** depuis l’adresse
suivante <http://developer.htc.com/adp.html>. Déposer le fichier dans /tmp

L’astuce est de copier les ROMs provenant du kit de développement du HTC Dream.

```bash
unzip -x
/tmp/signed-dream_devphone_userdebug-img-150275.zip -d /tmp/android/ cp
system.img /usr/local/android-sdk-linux_x86-1.5_r3/add-ons/google_apis-3/images/
cp userdata.img
/usr/local/android-sdk-linux_x86-1.5_r3/add-ons/google_apis-3/images/ sudo chmod
a+r /usr/local/android-sdk-linux_x86-1.5_r3/add-ons/google_apis-3/images/*.img
```

Préparer un périphérique virtuel

```bash
android create avd -t 3 -n virtual_phone
```

Lancer l’émulateur

```bash
emulator -avd virtual_phone
```

- Etape 1 cliquer sur l’écran, pour commencer l’inscription
- Etape 2 passer l’étape du tutoriel
- Etape 3,4 Créer ou utiliser un compte google
- Etape 5 Tester vos applications sur le market.

![android screenshot](/img/2012/android-1.png)
