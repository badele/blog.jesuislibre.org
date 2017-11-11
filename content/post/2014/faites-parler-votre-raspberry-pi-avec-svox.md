---
Date: 2014-02-25
Title: Faites parler votre Raspberry PI avec svox
SubTitle: Détaille comment utiliser la synthèse vocale sur un Raspberry PI
Section: Informatique
Aliases: /2014/2/25/faites-parler-votre-raspberry-pi-avec-svox
Tags:
- planet-libre
- Raspberry
- Domotique
- Opensource
---


Dans le cadre de mon projet domotique
[serialkiller](https://github.com/badele/serialkiller), j'ai créé un
module qui permet de dicter vocalement certains états de mes capteurs.
Comme par exemple lors d'un changement de température extérieure.

Pour avoir le support de la synthèse vocale sur Raspberry PI, le moyen
le plus simpe que j'ai trouvé, c'est d'utiliser la version Archlinux.
Celle-ci permet en quelques lignes de commandes d'avoir un système
opérationnel. Voici 2 exemples de fichiers audios générés via svox
[heure](/files/tts/2014/heure.wav) et [temp](/files/tts/2014/temp.wav) (voir les
commandes au bas de ce billet)

Installation de Archlinux ARM sur la carte SD
---------------------------------------------

{{< highlight bash>}}
cd /tmp
wget "http://archlinuxarm.org/os/ArchLinuxARM-rpi-latest.zip"
7z x ArchLinuxARM-rpi-latest.zip
dd bs=1M if=ArchLinuxARM*.img of=/dev/mmcblk0
sync
# Insérer la carte sur le raspberry PI et il vous suffit de booter dessus en allumant le raspberry PI
{{< /highlight >}}

### Configuration & Optimisation

Connecter votre Raspberry sur le réseau et se connecter avec le login
**root** et password **root**. Les optimisations suivantes permettent de
réduire l'écriture sur la carte SD

{{< highlight bash>}}
echo "/dev/root  /  ext4  noatime,discard  0  0" >> /etc/fstab
echo "tmpfs   /var/log        tmpfs   nodev,nosuid,size=16M   0       0" >> /etc/fstab
rm -R /var/log
ln -sf /dev/null ~/.bash_history
{{< /highlight>}}

### Installation de yaourt & upgrade

{{< highlight bash>}}
pacman -S yaourt
yaourt -Syua
{{< /highlight>}}

### Installation de svox

{{< highlight bash>}}
yaourt -S base-devel svox-pico-git
{{< /highlight>}}

### Exemples d'utilisation

{{< highlight bash>}}
pico2wave -l fr-FR -w /tmp/heure.wav "Bonjour cher linuxien, Il est 20h53" ; aplay /tmp/heure.wav
{{< /highlight>}}

Résultat : [heure](/files/tts/2014/heure.wav)

{{< highlight bash>}}
pico2wave -l fr-FR -w /tmp/temp.wav "Il fait une température extérieure de : 15°" ; aplay /tmp/temp.wav
{{< /highlight>}}

Résultat : [temp](/files/tts/2014/temp.wav)
