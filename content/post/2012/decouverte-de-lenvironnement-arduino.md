---
Date: 2012-10-07
Title: Découverte de l’environnement Arduino
bigimg:
- {src: "/img/2012/arduino-banner.png", desc: "Arduino logo"}
Image: "/img/2012/arduino-banner.png"
Section: Informatique
Aliases: /2012/10/7/decouverte-de-lenvironnement-arduino
Tags:
- planet-libre
- Fritzing
- Arduino
- Electronique
---


Afin d’aider à la compréhension de mes prochains billets concernant un
projet de domotique avec des kits arduino, j’ai décidé de faire une
petite introduction sur la technologie Arduino.

Arduino permet d’effectuer des montages électroniques sans avoir de
compétence particulière, me concernant je connais quelques notions comme
U=RI, je n’ai pas assez de pratique pour comprendre en profondeur le
fonctionnement d’un transistor ou un condensateur. C’est pour cela que
je me suis tourné vers Arduino, cette techno permet, de façon simple, de
créer de petits montages (ex: faire clignoter une lampe, mesurer la
température, etc …)

**Electronique classique VS Arduino**

Avant de voir en détails les bases de l’Arduino, nous allons comparer 2
montages qui effectuent la même fonctionnalité. L’une sous la forme d’un
montage électronique classique et l’autre sous forme de montage à base
d’Arduino. Ce montage permet de faire clignoter une led.

Montage classique

Schéma sur breadboard

![blink astable](/img/2010/blink_led_astable_bb_reduced.png)

Schéma électronique

![schema astable](/img/2010/blink_led_astable_schem_reduced.png)

Pour calculer la durée de l’allumage et de l’extinction, il faut jongler
avec les valeurs des résistances et des condensateurs.

Montage à base d’Arduino

Schéma sur breadboard

![breadboard](/img/2010/arduino_blink_bb_reduced.png)

**ATTENTION: Sur l’Arduino Uno, vous pouvez brancher une LED directement
sur la PIN 13 (car elle possède une résistance interne). Sur les autres
PIN, n’oubliez pas d’ajouter une résistance pour limiter l’intensité de
la LED.**

Schéma electronique

![schema reduit](/img/2010/arduino_blink_schem_reduced.png)

Le code

Arduino c’est quoi ?

Arduino c’est un packaging d’un microcontrôleur à base d’Atmel AVR + un
outil de développement. Ce kit permet de créer facilement des modules
électroniques sans avoir de compétence électronique particulière, de
plus les cartes Arduino sont publiées sous licence Creative Common. Il
existe plusieurs modèles de carte Arduino (Nano, Leonardo, LilyPad, Mega
2560). La plus utilisée est l’Arduino Uno.

**Détail de la carte Arduino Uno**

<img src="http://arduino.cc/en/uploads/Main/ArduinoUnoFront.jpg" width="75%" alt="Carte arduino" />

Arduino Uno est basée sur un microcontrôleur ATmega328 cadencé à 16Mhz.
Celle ci comprend :

-   14 Entrées / Sorties digitales (0/1 – On/Off), dont 6 qui peuvent
    être utlisées en mode PWM, 40mA par sortie
-   6 entrées analogiques (0-5V ou 0-3.3V) avec une plage de 1024
    échantillons.
-   la carte peut être alimentée par USB ou par source extérieure (7V –
    12V)
-   32Ko pour le stockage du code.

*Entrées/Sorties spéciales* :

-   Liaison série, 0 (RX) and 1 (TX)
-   Génération d’interruption, les prises 2,3 peuvent générées des
    interruptions
-   Support du mode PWM 3, 5, 6, 9, 10, and 11 (schématisé \~ sur la
    carte, voir photo )
-   Communication SPI, 10 (SS), 11 (MOSI), 12 (MISO), 13 (SCK).
-   Communication TWI, A4 or SDA & A5 or SCL
-   **Led sans utilisation de résistance, la sortie N° 13 permet de
    connecter directement une led sans utiliser de résistance.**

Les shields

Les shields permettent d’ajouter de nouvelles fonctionnalités à une
carte Arduino, par exemple ajout du support du GPS, Ethernet, Bluetooth,
GSM, Wi-Fi, écran LCD, etc …. Ces modules sont conçus pour s’interfacer
facilement avec l’Arduino, ils s’enfichent sur l’Arduino et dupliquent
les entrées/sorties sur la carte Shields. Exemple de mise en oeuvre
d’une carte shields

<img src="http://site.gravitech.us/Arduino/SHIELD7/7-SEG_SHIELD-03rs.jpg" width="75%" alt="arduino shield" />

Le mode PWM

Le PWM est une astuce permettant de modifier la luminance en modifiant
la période on/off d’une led, il permet également de modifier la vitesse
d’un moteur. Ça joue en fait sur la durée des périodes hautes/basses,
voir schéma ci-dessous

![detail pwm](http://arduino.cc/en/uploads/Tutorial/pwm.gif)

[Plan de la
carte](http://arduino.cc/en/uploads/Main/Arduino_Uno_Rev3-schematic.pdf)
Arduino Uno sous licence Créative Common

**IDE** L’Arduino est fourni avec un [kit de
développement](http://arduino.cc/hu/Main/Software) qui permet de
compiler du C, C++ et de l’envoyer directement sur la carte, voici un
aperçu de l’IDE.

![IDE pour arduino](http://gelendir.github.com/htcpcpd/img/arduinoIde.png)

**Concevoir des schémas** Les schémas visibles sur ce billet ont été
créés avec Fritzing, outil développé par l’université de Postdam en
Allemagne. Il est vraiment facile à prendre en main. Il permet de
schématiser vos montages sur breadboard, ainsi que le schéma
électronique correspondant, voire même le PCB.

<img src="http://www.creativeapplications.net/wp-content/uploads/2009/05/fritzing-3.png" width="75%" alt="fritzing" />


Voila, en espérant que ça vous donnera envie d’aller plus loin…
