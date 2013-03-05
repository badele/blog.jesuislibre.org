public: yes
tags: [ Electronique, Arduino, planet-libre, Fritzing ]
summary: |
  Afin d’aider à la compréhension de mes prochains billets concernant un projet de domotique avec des kits arduino, j’ai décidé de faire une petite introduction sur la technologie Arduino.

Découverte de l’environnement Arduino
=====================================

Afin d’aider à la compréhension de mes prochains billets concernant un projet de domotique avec des kits arduino, j’ai décidé de faire une petite introduction sur la technologie Arduino.

Arduino permet d’effectuer des montages électroniques sans avoir de compétence particulière, me concernant je connais quelques notions comme U=RI, je n’ai pas assez de pratique pour comprendre en profondeur le fonctionnement d’un transistor ou un condensateur. C’est pour cela que je me suis tourné vers Arduino, cette techno permet, de façon simple, de créer de petits montages (ex: faire clignoter une lampe, mesurer la température, etc …)

**Electronique classique VS Arduino**

Avant de voir en détails les bases de l’Arduino, nous allons comparer 2 montages qui effectuent la même fonctionnalité. L’une sous la forme d’un montage électronique classique et l’autre sous forme de montage à base d’Arduino. Ce montage permet de faire clignoter une led.

Montage classique

Schéma sur breadboard

.. image:: /static/blink_led_astable_bb_reduced.png
   :width: 100%

Schéma électronique

.. image:: /static/blink_led_astable_schem_reduced.png
   :width: 100%

Pour calculer la durée de l’allumage et de l’extinction, il faut jongler avec les valeurs des résistances et des condensateurs.

Montage à base d’Arduino

Schéma sur breadboard

.. image:: /static/arduino_blink_bb_reduced.png

**ATTENTION: Sur l’Arduino Uno, vous pouvez brancher une LED directement sur la PIN 13 (car elle possède une résistance interne). Sur les autres PIN, n’oubliez pas d’ajouter une résistance pour limiter l’intensité de la LED.**

Schéma electronique

.. image:: /static/arduino_blink_schem_reduced.png

Le code

.. sourcecode:: c

   int ledPin = 13; // LED connected to digital pin 13

   void setup()
   {
     pinMode(ledPin, OUTPUT); // sets the digital pin as output
   }

   void loop()
   {
     digitalWrite(ledPin, HIGH); // sets the LED on
     delay(1000); // waits for a second
     digitalWrite(ledPin, LOW); // sets the LED off
     delay(1000); // waits for a second
   }

Arduino c’est quoi ?

Arduino c’est un packaging d’un microcontrôleur à base d’Atmel AVR + un outil de développement. Ce kit permet de créer facilement des modules électroniques sans avoir de compétence électronique particulière, de plus les cartes Arduino sont publiées sous licence Creative Common. Il existe plusieurs modèles de carte Arduino (Nano, Leonardo, LilyPad, Mega 2560). La plus utilisée est l’Arduino Uno.

**Détail de la carte Arduino Uno**

.. image:: http://arduino.cc/en/uploads/Main/ArduinoUnoFront.jpg
   :width: 70%

Arduino Uno est basée sur un microcontrôleur ATmega328 cadencé à 16Mhz. Celle ci comprend :

- 14 Entrées / Sorties digitales (0/1 – On/Off), dont 6 qui peuvent être utlisées en mode PWM, 40mA par sortie
- 6 entrées analogiques (0-5V ou 0-3.3V) avec une plage de 1024 échantillons.
- la carte peut être alimentée par USB ou par source extérieure (7V – 12V)
- 32Ko pour le stockage du code.

*Entrées/Sorties spéciales* :

- Liaison série, 0 (RX) and 1 (TX)
- Génération d’interruption, les prises 2,3 peuvent générées des interruptions
- Support du mode PWM 3, 5, 6, 9, 10, and 11 (schématisé ~ sur la carte, voir photo )
- Communication SPI, 10 (SS), 11 (MOSI), 12 (MISO), 13 (SCK).
- Communication TWI, A4 or SDA & A5 or SCL
- **Led sans utilisation de résistance, la sortie N° 13 permet de connecter directement une led sans utiliser de résistance.**

Les shields

Les shields permettent d’ajouter de nouvelles fonctionnalités à une carte Arduino, par exemple ajout du support du GPS, Ethernet, Bluetooth, GSM, Wi-Fi, écran LCD, etc …. Ces modules sont conçus pour s’interfacer facilement avec l’Arduino, ils s’enfichent sur l’Arduino et dupliquent les entrées/sorties sur la carte Shields. Exemple de mise en oeuvre d’une carte shields

.. image:: http://site.gravitech.us/Arduino/SHIELD7/7-SEG_SHIELD-03rs.jpg

Le mode PWM

Le PWM est une astuce permettant de modifier la luminance en modifiant la période on/off d’une led, il permet également de modifier la vitesse d’un moteur. Ça joue en fait sur la durée des périodes hautes/basses, voir schéma ci-dessous

.. image:: http://arduino.cc/en/uploads/Tutorial/pwm.gif

`Plan de la carte <http://arduino.cc/en/uploads/Main/Arduino_Uno_Rev3-schematic.pdf>`_ Arduino Uno sous licence Créative Common

**IDE**
L’Arduino est fourni avec un `kit de développement <http://arduino.cc/hu/Main/Software>`_ qui permet de compiler du C, C++ et de l’envoyer directement sur la carte, voici un aperçu de l’IDE.

.. image:: http://gelendir.github.com/htcpcpd/img/arduinoIde.png

**Concevoir des schémas**
Les schémas visibles sur ce billet ont été créés avec Fritzing, outil développé par l’université de Postdam en Allemagne. Il est vraiment facile à prendre en main. Il permet de schématiser vos montages sur breadboard, ainsi que le schéma électronique correspondant, voire même le PCB.

.. image:: http://www.creativeapplications.net/wp-content/uploads/2009/05/fritzing-3.png

Voila, en espérant que ça vous donnera envie d’aller plus loin…

.. raw:: html

         <div id="comments">


		 <h3 id="comments-title">Une réponse à <em>Découverte de l’environnement Arduino</em></h3>


		 <ol class="commentlist">
		 <li id="li-comment-591" class="comment even thread-even depth-1">
		 <div id="comment-591">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/bb1d4359e44124ab92ca5fbf4070fa9b?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn"><a class="url" rel="external nofollow" href="http://www.civade.com">ewidance</a></cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2012/10/decouverte-de-lenvironnement-arduino/comment-page-1/#comment-591">
		 17 février 2013 à 10 h 50 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Alors là…. Je suis scotché sur Fritzing… que je ne connaissais pas. Merci qui? Merci Bruno!</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
		 </ol>
         </div>
