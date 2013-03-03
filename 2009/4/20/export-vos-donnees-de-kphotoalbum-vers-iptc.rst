public: yes
tags: [planet-libre, Photo, Script ]
summary: |
  Export de vos données de KPhotoAlbum vers IPTC

KPhotoAlbum vers le format IPTC
===============================

Depuis environ 5 ans j’utilise KPhotoAlbum. Afin d’éviter de devoir retagger mes photos pour les  partager sur mon `compte flickr <http://www.flickr.com/photos/b_adele/>`_, j’ai modifié un script de Pierre Doucet trouvé sur `le site linuxfr <http://linuxfr.org/~doucetp/20428.html>`_


A propos
--------

- `KPhotoAlbum <http://kphotoalbum.org/>`_ (se nommait auparavant kimdaba), ce logiciel fonctionne sous KDE et permet d’associer pour chaque photo des mots clefs comme par exemple (Lieu, Personne, Evènement).  Vous pouvez ensuite retrouver très rapidement des photos en fonction des mots clefs désirés. Ce logiciel me permet de retrouver en moins de 5 secondes des photos sur une base de + de 20.000 photos.

- `IPTC <http://fr.wikipedia.org/wiki/International_Press_Telecommunications_Council>`_ Standard permettant de véhiculer des informations directement dans la photo. Ceci permet donc visualiser les informations depuis un logiciel compatible IPTC.

Installation
------------

Avant d’utiliser le script il faut avant tout installer les librairies perl.

.. sourcecode:: perl

   mkdir -p ~/local/bin
   perl -MCPAN -e shell

Répondre oui à la question posée, ensuite exécuter les lignes suivantes

.. sourcecode:: perl

   cpan>
   o conf makepl_arg PREFIX=~/local
   o conf commit
   install Image::Kimdaba
   install Image::IPTCInfo

Le script
---------
Copier le script ci dessous vers le fichier kphotoalbum2iptc.pl

Par soucis de sécurité le script s’exécute en mode simulation, pour l’activer, modifier la variable onlyparse à 0


**Exemple d’utilisation**

.. sourcecode:: bash

   ./kphotoalbum2iptc.pl /path/album "^sous repertoire.*.jpg|.jpeg"

kphotoalbum2iptc.pl

.. sourcecode:: perl

   #!/usr/bin/perl -w
   # kphotoalbum2iptc.pl

   # Param 1 : Chemin du catalogue KPhotoAlbum
   # Param 2 : Filtre (ex: "^dvd 3.*\.jpg|\.jpeg" )


   # A MODIFIER
   use lib qw(/home/b_adele/local/share/perl5/site_perl/5.10.0/);
   $verbose=0;
   $onlyparse=0;

   # Chargement des librairies
   use Image::Kimdaba; 
   use Image::IPTCInfo; 

   my @ListOfPictures;

   $folder = $ARGV[0];
   $filter = $ARGV[1]; 

   # Parse le catalogue KPhotoAlbum
   print "Chemin de base: $folder\n";
   parseDB( "$folder" );

   # Compte le nombre de photos
   my $nb1= scalar keys %imageattributes;
   my $nb2= scalar keys %imageoptions;
   print "$nb1 photos dont $nb2 avec des tags:\n";


   # Ajout des infos dans la photo (IPTC)
   $count=0;
   foreach $kphoto (keys(%imageoptions))
   {
       if ($kphoto =~ m/$filter/i ) {
           $count++;
       print "Photo en cours : $folder/$kphoto (N° $count)\n";
           my $iptc = create Image::IPTCInfo("$folder/$kphoto");
           foreach $kkey (keys(%{$imageoptions{$kphoto}}))
           {
               if ($verbose) { print "--> $kkey\n"; }
               foreach $values (@{${$imageoptions{$kphoto}}{$kkey}})
               {
                   if ($verbose) { print "-----> $values\n"; }
                   $iptc->AddKeyword("$values");
               }
           }
    
       if (!$onlyparse) { $iptc->Save();}
       }
   }

   print "$count photos traitées";

.. raw:: html
         <div id="comments">


		 <h3 id="comments-title">20 réponses à <em>Export de vos données de KPhotoAlbum vers IPTC</em></h3>


		 <ol class="commentlist">
		 <li id="li-comment-5" class="comment even thread-even depth-1">
		 <div id="comment-5">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/ac2ae9bc6f0c5b980cdca51af9c77ebd?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn"><a class="url" rel="external nofollow" href="http://www.equinoxefr.org">Equinoxefr</a></cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-5">
		 20 avril 2009 à 13 h 38 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Salut,</p>
         <p>Amusant de voir un vieux script, fait il y a quelques années, retrouver une utilité <img class="wp-smiley" alt=";-)" src="http://blog.jesuislibre.org/wp-includes/images/smilies/icon_wink.gif"> </p>
         <p>Depuis quelques temps, je suis passé à F-spot sous Gnome, toujours avec l’aide de quelques scripts perl…</p>
         <p>Pierre</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-6" class="comment odd alt thread-odd thread-alt depth-1">
		 <div id="comment-6">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/f068e9c2522ba565fb6d150dfe096f88?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">moSaN</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-6">
		 20 avril 2009 à 15 h 23 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Juste pour être certain de bien comprendre le script. Je suis loin de tout comprendre dès qu’il s’agit de perl.</p>
         <p>Pour désactiver le mode simulation il faut changer la variable «onlyparse» mais je ne vois aucune référence à cette variable dans le bout de code.<br>
         Ne serait-ce pas plutôt la variable «verbose».</p>
         <p>Ou alors la variable «onlyparse» est une variable associée à IPTC qui bloque la fonction d’écriture Save() ?</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-7" class="comment even thread-even depth-1">
		 <div id="comment-7">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/7f435d6198e0dcbb633de9676b00a28d?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">davitof</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-7">
		 20 avril 2009 à 17 h 20 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Euh, je ne connais pas perl, alors je dis surement une bêtise, mais tu es sûr, pour la variable onlyparse? Je n’en vois pas trace dans le script…</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-8" class="comment byuser comment-author-b_adele bypostauthor odd alt thread-odd thread-alt depth-1">
		 <div id="comment-8">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/f4a804b1c2256bdefb9674105039dd98?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn"><a class="url" rel="external nofollow" href="http://www.jesuislibre.org">b_adele</a></cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-8">
		 20 avril 2009 à 21 h 02 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Rien de tout çà <img class="wp-smiley" alt=":)" src="http://blog.jesuislibre.org/wp-includes/images/smilies/icon_smile.gif"> , ce n’était pas le bon code, j’ai corrigé l’article.</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-10" class="comment even thread-even depth-1">
		 <div id="comment-10">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/7f435d6198e0dcbb633de9676b00a28d?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">davitof</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-10">
		 20 avril 2009 à 22 h 01 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>@moSaN: je ne crois pas que ce soit verbose. Aussi bien par le sens du mot «&nbsp;verbose&nbsp;» en anglais que par ce que je crois comprendre du script, je pense que la variable verbose sert uniquement à afficher plus d’informations en cours d’exécution.</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-11" class="comment odd alt thread-odd thread-alt depth-1">
		 <div id="comment-11">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/7f435d6198e0dcbb633de9676b00a28d?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">davitof</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-11">
		 20 avril 2009 à 22 h 03 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>@b_adele: ah ben là oui, je comprends <img class="wp-smiley" alt=":-)" src="http://blog.jesuislibre.org/wp-includes/images/smilies/icon_smile.gif">  C’est vrai que le perl ressemble au php. Ou plutôkt le contraire <img class="wp-smiley" alt=";-)" src="http://blog.jesuislibre.org/wp-includes/images/smilies/icon_wink.gif"> </p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-13" class="comment even thread-even depth-1">
		 <div id="comment-13">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/d25e7ff6feea9e6fc33d2d57d722f6c9?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn"><a class="url" rel="external nofollow" href="http://www.road2mayotte.org/blog/">Christophe</a></cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-13">
		 21 avril 2009 à 7 h 58 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Bonjour, </p>
         <p>Sinon, il y a Sagittarius :</p>
         <p><a rel="nofollow" href="http://ubunteros.tuxfamily.org/spip.php?article185">http://ubunteros.tuxfamily.org/spip.php?article185</a></p>
         <p>@+</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-15" class="comment byuser comment-author-b_adele bypostauthor odd alt thread-odd thread-alt depth-1">
		 <div id="comment-15">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/f4a804b1c2256bdefb9674105039dd98?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn"><a class="url" rel="external nofollow" href="http://www.jesuislibre.org">b_adele</a></cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-15">
		 21 avril 2009 à 8 h 44 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>@Christophe, je ne connaissais pas Sagittarius, néanmoins il ne semble pas pouvoir exporter les tags déjà saisies dans KPhotoAlbum vers le format IPTC, le but du script est justement d’éviter de ressaisir les informations déjà saisies précédemment sur KPhotoAlbum.</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-16" class="comment even thread-even depth-1">
		 <div id="comment-16">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/f068e9c2522ba565fb6d150dfe096f88?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">moSaN</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-16">
		 21 avril 2009 à 10 h 32 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Merci b_adele pour ce script qui devrait m’éviter bien du boulot <img class="wp-smiley" alt=":)" src="http://blog.jesuislibre.org/wp-includes/images/smilies/icon_smile.gif"> </p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-18" class="comment odd alt thread-odd thread-alt depth-1">
		 <div id="comment-18">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/2114a35cac7412d33a932859042b8006?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn"><a class="url" rel="external nofollow" href="http://fromlugdunum.free.fr/blog">fromlugdunum</a></cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-18">
		 24 avril 2009 à 15 h 30 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Fspot gère mes TAG directement dans flickr…c’est pratique.</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-63" class="comment even thread-even depth-1">
		 <div id="comment-63">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/2480dac63eb17c950bf870cb5c28e38f?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">Teebo</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-63">
		 6 février 2010 à 12 h 31 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Bonjour,<br>
         Depuis hier soir je me demande bien comment changer de logiciel sans perdre mes infos rentrées dans Kphotoalbum, et là ce matin, miracle, je tombe sur ce post (désolé de jouer les archéologues <img class="wp-smiley" alt=";)" src="http://blog.jesuislibre.org/wp-includes/images/smilies/icon_wink.gif">  ), j’essaye donc comme indiqué, il semble que l’installation se passe bien (Warning usually Harmless de YAML) mais quand j’essaye de lancer le script :<br>
         BEGIN failed&ndash;compilation aborted at ./kphotoalbum2iptc.pl line 14.</p>
         <p>Je suis sous Ubuntu Koala.<br>
         Quelqu’un aurait une idée pour moi?</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-64" class="comment odd alt thread-odd thread-alt depth-1">
		 <div id="comment-64">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/2480dac63eb17c950bf870cb5c28e38f?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">Teebo</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-64">
		 6 février 2010 à 14 h 21 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>EDIT: On oublie tout, appelez moi stupide, j’avais pas changé le chemin (celui directement sous le gros «&nbsp;A MODIFIER&nbsp;», oui oui, celui là même…</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-100" class="comment even thread-even depth-1">
		 <div id="comment-100">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/ad0b9b83ce3a7c702b200bc48fdaa8da?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">Chaland</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-100">
		 30 novembre 2010 à 0 h 25 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Je voudrais bien pouvoir transférer les infos de 10000photos de kphotoalbum sur Digikam.<br>
         J’ai essayé le script mais je ni arrive pas . Voici ce que j’ai fait :<br>
         Image ::kimdaba et Image::IPTCInfo sont bien installés.<br>
         [root@sonypierre home]# ./kphotoalbum2iptc.pl /pierre/kphotoalbum.<br>
         Le script se trouve dans home . Kphotoalbum est situé dans home/pierre.<br>
         Voici le script:<br>
         #! /usr/bin/perl -w<br>
         # kphotoalbum2iptc.pl</p>
         <p># Param 1 : /pierre<br>
         # Param 2 : «&nbsp;\.jpeg&nbsp;» </p>
         <p># A MODIFIER</p>
         <p>use lib qw(/pierre/local/share/perl5/site_perl/5.10.0/);<br>
         $verbose=0;<br>
         $onlyparse=0;</p>
         <p># Chargement des librairies<br>
         use Image::Kimdaba;<br>
         use Image::IPTCInfo;</p>
         <p>my @ListOfPictures;</p>
         <p>$folder = $ARGV[0];<br>
         $filter = $ARGV[1];</p>
         <p># Parse le catalogue KPhotoAlbum<br>
         print «&nbsp;Chemin de base: $folder\n&nbsp;»;<br>
         parseDB( «&nbsp;$folder&nbsp;» );</p>
         <p># Compte le nombre de photos<br>
         my $nb1= scalar keys %imageattributes;<br>
         my $nb2= scalar keys %imageoptions;<br>
         print «&nbsp;$nb1 photos dont $nb2 avec des tags:\n&nbsp;»;</p>
         <p># Ajout des infos dans la photo (IPTC)<br>
         $count=0;<br>
         foreach $kphoto (keys(%imageoptions))<br>
         {<br>
         if ($kphoto =~ m/$filter/i ) {<br>
         $count++;<br>
         print «&nbsp;Photo en cours : $folder/$kphoto (N° $count)\n&nbsp;»;<br>
         my $iptc = create Image::IPTCInfo(«&nbsp;$folder/$kphoto&nbsp;»);<br>
         foreach $kkey (keys(%{$imageoptions{$kphoto}}))<br>
         {<br>
         if ($verbose) { print «&nbsp;&ndash;&gt; $kkey\n&nbsp;»; }<br>
         foreach $values (@{${$imageoptions{$kphoto}}{$kkey}})<br>
         {<br>
         if ($verbose) { print «&nbsp;&mdash;&ndash;&gt; $values\n&nbsp;»; }<br>
         $iptc-&gt;AddKeyword(«&nbsp;$values&nbsp;»);<br>
         }<br>
         }</p>
         <p>    if (!$onlyparse) { $iptc-&gt;Save();}<br>
         }<br>
         }</p>
         <p>print «&nbsp;$count photos traitées&nbsp;»; </p>
         <p>Lorsque je le lance Voici le résultat il s’arrête à la ligne 26.<br>
         [root@sonypierre home]# ./kphotoalbum2iptc.pl /home/pierre/kphotoalbum<br>
         Chemin de base: /home/pierre/kphotoalbum<br>
         Can not find KimDaBa’s database at ./kphotoalbum2iptc.pl line 26.</p>
         <p>Pouvez vous m’aider? Merci</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-101" class="comment odd alt thread-odd thread-alt depth-1">
		 <div id="comment-101">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/ad0b9b83ce3a7c702b200bc48fdaa8da?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">Chaland</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-101">
		 30 novembre 2010 à 11 h 57 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Désolé j’ai fait une erreur mon album s’appelle Kphotoalbum avec un K majuscule.<br>
         Maintenant j’ai l’anomalie suivante:<br>
         /home/pierre/Kphotoalbum: /home/pierre/Kphotoalbum</p>
         <p>reference to invalid character number at line 1040, column 48, byte 46620 at /usr/lib/perl5/vendor_perl/5.10.1/i386-linux-thread-multi/XML/Parser.pm line 187<br>
         Avez-vous une idée? Merci</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-103" class="comment even thread-even depth-1">
		 <div id="comment-103">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/ebaf214bab53f237fef6699801928544?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">Keuronde</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-103">
		 8 décembre 2010 à 16 h 10 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>=&gt; Chaland<br>
         A ta place, j’ouvrirai le fichier XML pour voir ce qui se trouve à la ligne 1040, colonne 48. Il y a peut-être un caractère étrange qui te donnera une idée sur ce qui ne va pas…</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-233" class="comment odd alt thread-odd thread-alt depth-1">
		 <div id="comment-233">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/ad0b9b83ce3a7c702b200bc48fdaa8da?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">Chaland</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-233">
		 28 octobre 2011 à 12 h 33 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>kphotoalbum2iptc.pl<br>
         ! /usr/bin/perl -w<br>
         # kphotoalbum2iptc.pl</p>
         <p># Param 1 : /home/pierre<br>
         # Param 2 : &lt;&gt;</p>
         <p># A MODIFIER<br>
         use lib qw(/home/pierre/local/share/perl5/site_perl/5.12.3/);<br>
         $verbose=0;<br>
         $onlyparse=0;</p>
         <p># Chargement des librairies<br>
         use Image::Kimdaba;<br>
         use Image::IPTCInfo;</p>
         <p>my @ListOfPictures;</p>
         <p>$folder = $ARGV[0];<br>
         $filter = $ARGV[1];</p>
         <p># Parse le catalogue kphotoalbumavec<br>
         print «&nbsp;/home/pierre/kphotoalbum:$folder\n&nbsp;»;<br>
         parseDB( «&nbsp;$folder&nbsp;» );</p>
         <p># Compte le nombre de photos<br>
         my $nb1= scalar keys %imageattributes;<br>
         my $nb2= scalar keys %imageoptions;<br>
         print «&nbsp;$nb1 photos dont $nb2 avec des tags:\n&nbsp;»;</p>
         <p># Ajout des infos dans la photo (IPTC)<br>
         $count=0;<br>
         foreach $kphoto (keys(%imageoptions))<br>
         {<br>
         if ($kphoto =~ m/$filter/i ) {<br>
         $count++;<br>
         print «&nbsp;Photo en cours : $folder/$kphoto (N° $count)\n&nbsp;»;<br>
         my $iptc = create Image::IPTCInfo(«&nbsp;$folder/$kphoto&nbsp;»);<br>
         foreach $kkey (keys(%{$imageoptions{$kphoto}}))<br>
         {<br>
         if ($verbose) { print «&nbsp;&ndash;&gt; $kkey\n&nbsp;»; }<br>
         foreach $values (@{${$imageoptions{$kphoto}}{$kkey}})<br>
         {<br>
         if ($verbose) { print «&nbsp;&mdash;&ndash;&gt; $values\n&nbsp;»; }<br>
         $iptc-&gt;AddKeyword(«&nbsp;$values&nbsp;»);<br>
         }<br>
         }</p>
         <p>    if (!$onlyparse) { $iptc-&gt;Save();}<br>
         }<br>
         }</p>
         <p>print «&nbsp;$count photos traitées&nbsp;»; </p>
         <p>Ce script depuis mon dernier commentaire a toujours bien fonctionner.<br>
         Aujourd’hui je suis passé à perl 5.12.3.<br>
         Le script stoppe la ligne 36 avec cette info:<br>
         «&nbsp;Use of uninitialized value $filter in regexp compilation at ./kphotoalbum2iptc.pl line 36.&nbsp;»<br>
         Il traite toutes les photos mais ne sort rien.<br>
         Avez vous une idée du problème?<br>
         Merci</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-234" class="comment byuser comment-author-b_adele bypostauthor even thread-even depth-1">
		 <div id="comment-234">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://1.gravatar.com/avatar/f4a804b1c2256bdefb9674105039dd98?s=40&amp;d=http%3A%2F%2F1.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn"><a class="url" rel="external nofollow" href="http://www.jesuislibre.org">b_adele</a></cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-234">
		 28 octobre 2011 à 13 h 10 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Avez vous indiquer les 2 paramètres lors du lancement de votre commande ? Il semblerait que la variable $filter soit vide. Sinon je ne vois pas.</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-235" class="comment odd alt thread-odd thread-alt depth-1">
		 <div id="comment-235">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/ad0b9b83ce3a7c702b200bc48fdaa8da?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">Chaland</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-235">
		 28 octobre 2011 à 16 h 04 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Je ne comprend pas. En fait j’ai ceci: Param 2 : &lt;&gt;<br>
         Est ce correct?<br>
         De plus j’ai un problème sur cpan je ne peux installer per5 qu’en root et sur /root/local pourquoi?</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-236" class="comment even thread-even depth-1">
		 <div id="comment-236">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/ad0b9b83ce3a7c702b200bc48fdaa8da?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">Chaland</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-236">
		 28 octobre 2011 à 16 h 09 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>param 2 :*\.jpeg</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
	     <li id="li-comment-237" class="comment odd alt thread-odd thread-alt depth-1">
		 <div id="comment-237">
		 <div class="comment-author vcard">
		 <img width="40" height="40" class="avatar avatar-40 photo" src="http://0.gravatar.com/avatar/ad0b9b83ce3a7c702b200bc48fdaa8da?s=40&amp;d=http%3A%2F%2F0.gravatar.com%2Favatar%2Fad516503a11cd5ca435acc9bb6523536%3Fs%3D40&amp;r=G" alt="">			<cite class="fn">Chaland</cite> <span class="says">dit&nbsp;:</span>		</div><!-- .comment-author .vcard -->
		 
		 <div class="comment-meta commentmetadata"><a href="http://blog.jesuislibre.org/2009/04/export-vos-donnees-de-kphotoalbum-vers-iptc/comment-page-1/#comment-237">
		 28 octobre 2011 à 22 h 48 min</a>		</div><!-- .comment-meta .commentmetadata -->

		 <div class="comment-body"><p>Vous aviez raison au lancement  j’avais oublié les 2 paramètres.<br>
         Maintenant il traite toutes les données et affiche donnée en cours.<br>
         Par contre ,il n’édite pas le fichier IPTCI.<br>
         Merci de votre aide</p>
         </div>

		 <div class="reply">
		 </div><!-- .reply -->
	     </div><!-- #comment-##  -->

	     </li>
		 </ol>
         </div>
