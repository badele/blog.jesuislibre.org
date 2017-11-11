---
Date: 2014-10-04
Title: Questions secrètes version 2
SubTitle: Les questions secrètes, pas si secrètes que cela.
Section: Informatique
Aliases: /2014/10/4/questions-secretes-version-2
Tags:
- planet-libre
- Internet
- Sécurité
---


![Copie d'ecran d'une question secrete](/img/2014/fb4.png)

Je ne suis pas trés friand des applications Clouds. D'une part, comment
se laisser tenter pour stocker ses données privées sur des serveurs
publics ? Et d'autre part, comment laisser une totale confiance aux
mains d'une seule équipe de développement qui ne vous indique même pas
les règles de sécurité, mis à part de vous dire qu'ils sont certifiés
[ISO 27001](http://fr.wikipedia.org/wiki/ISO/CEI_27001) ? La preuve en
est avec l'affaire des [photos
volées](http://www.lemondeinformatique.fr/actualites/lire-piratage-de-icloud-l-attaque-par-force-brute-certainement-utilisee-58479.html)
des stars sur les serveurs d'Apple. Les photos étaient stockées sur le
cloud d'Apple. Il semblerait que cela soit dû à une attaque par brute
force. Comme à son habitude les sociétés dans un premier temps indiquent
que ce n'est pas de [leurs
fautes](http://www.journaldugeek.com/2014/09/03/pour-apple-icloud-nest-pour-rien-dans-la-fuite-des-photos-denudees/),
pour ensuite sortir une [mise à
jour](http://www.numerama.com/magazine/30405-photos-de-stars-nues-volees-sur-icloud-apple-serait-bien-fautif.html).

Plusieurs questions se posent à moi : comment une boite comme Apple
puisse **autoriser le brute force** ? Et comment est-il possible qu'elle
n'ait pas une procédure stricte lorsqu'une authentification est requise
? Que ce soit via leur interface web ou depuis leur application mobile
ou via leur API ? Et qu'il n'impose pas une limitation du nombre de mots
de passe erronés par minute ?

Question secrète
----------------

Je vais maintenant en venir aux questions secrètes. En 2009 j'avais déjà
écris un
[billet](http://blog.jesuislibre.org/2009/5/20/webmail-faille-de-securite-des-questions-non-secretes/)
sur le risque de ces questions secrètes. Je trouve que l'on ne
sensibilise pas assez les utilisateurs sur le risque encouru.

Dernièrement j'ai soumis une requête au support de Facebook en pensant
avoir trouvé une brèche sur le respect de la vie privée des
utilisateurs, notamment sur la divulgation partielle d'une adresse
email. En effet lorsque un utilisateur désire réinitialiser son mot de
passe, il doit passer par un système de question secrète, du style "Quel
est le nom de ton ami(e)". Cette étape peut être outrepassée. Mais pour
Facebook ceci ne semble pas être une violation de vie privée, mais une
fonctionnalité ! Ce qui peut se comprendre, car Facebook ne semble pas
vouloir perdre l'historique d'un utilisateur.

Ci-dessous je vais détailler la version par défaut pour réinitialiser
son mot de passe.

Récupération adresse email partielle classique
----------------------------------------------

Voici en temps normal les étapes pour récupérer son adresse email

-   Ouvrir le navigateur web en mode privé afin de ne pas utiliser sa
    connexion Facebook en cours
-   Se connecter à l'adresse suivante
    <https://www.facebook.com/login/identify?ctx=reason>
-   Saisir son nom et prénom

![image](/img/2014/fb1.png)

-   Saisir le nom de son ami(e)

![image](/img/2014/fb2.png)


-   Indiquer les raisons pour lesquelles vous ne pouvez pas vous
     authentifier

 ![image](/img/2014/fb3.png)

-   Vous pouvez apercevoir une partie de l'adresse d'inscription sur
    Facebook.

 ![image](/img/2014/fb4.png)

Récupération adresse version courte
-----------------------------------

Je vais ici détailler la récupération d'une adresse email partielle,
sans passer par l'étape question secrète. Imaginons que je veuille
connaître l'adresse email d'inscription du compte Facebook de bruno
adele. Avant d'effectuer les étapes ci-dessous, je récupère l'URL
Facebook du compte de l'utilisateur, ex
<https://www.facebook.com/bruno.adele>.

 -   Ouvrir le navigateur web en mode privé afin de ne pas utiliser sa
     connexion Facebook en cours
 -   Se connecter à l'adresse suivante
     <https://www.facebook.com/login/identify?ctx=reason>
 -   Saisir la fin de l'URL du compte Facebook. ex: bruno.adele
 -   Vous pouvez maintenant apercevoir une partie de l'adresse
     d'inscription sur Facebook.

 ![image](/img/2014/fb4.png)

Il n'est pas trop difficile de constater que mon adresse email peux être
"brunoadele à gmail.com" ou "bruno.adele à jesuislibre.org". De fil en
aiguille, il pourrait être facile d'accéder à un compte email.
