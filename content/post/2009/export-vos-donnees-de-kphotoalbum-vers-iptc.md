---
Date: 2009-04-20T00:02:00
Title: KPhotoAlbum vers le format IPTC
Subtitle: Export de vos données de KPhotoAlbum vers IPTC
Slug: export-vos-donnees-de-kphotoalbum-vers-iptc
Section: Informatique
Aliases: /2009/4/20/export-vos-donnees-de-kphotoalbum-vers-iptc
Tags:
- planet-libre
- Photo
- Script
---

Depuis environ 5 ans j’utilise KPhotoAlbum. Afin d’éviter de devoir
retagger mes photos pour les partager sur mon [compte
flickr](http://www.flickr.com/photos/b_adele/), j’ai modifié un script
de Pierre Doucet trouvé sur [le site
linuxfr](http://linuxfr.org/~doucetp/20428.html)

A propos
--------

-   [KPhotoAlbum](http://kphotoalbum.org/) (se nommait auparavant
    kimdaba), ce logiciel fonctionne sous KDE et permet d’associer pour
    chaque photo des mots clefs comme par exemple (Lieu, Personne,
    Evènement). Vous pouvez ensuite retrouver très rapidement des photos
    en fonction des mots clefs désirés. Ce logiciel me permet de
    retrouver en moins de 5 secondes des photos sur une base de + de
    20.000 photos.
-   [IPTC](http://fr.wikipedia.org/wiki/International_Press_Telecommunications_Council)
    Standard permettant de véhiculer des informations directement dans
    la photo. Ceci permet donc visualiser les informations depuis un
    logiciel compatible IPTC.

Installation
------------

Avant d’utiliser le script il faut avant tout installer les librairies
perl.

{{< highlight bash>}}
mkdir -p ~/local/bin
perl -MCPAN -e shell
{{< /highlight>}}

Répondre oui à la question posée, ensuite exécuter les lignes suivantes

{{< highlight plaintext>}}
cpan>
o conf makepl_arg PREFIX=~/local
o conf commit
install Image::Kimdaba
install Image::IPTCInfo
{{< /highlight>}}

Le script
---------

Copier le script ci dessous vers le fichier kphotoalbum2iptc.pl

Par soucis de sécurité le script s’exécute en mode simulation, pour
l’activer, modifier la variable onlyparse à 0

**Exemple d’utilisation**

{{< highlight bash>}}
./kphotoalbum2iptc.pl /path/album "^sous repertoire.*.jpg|.jpeg"
{{< /highlight>}}

Fichier **kphotoalbum2iptc.pl**

{{< highlight perl>}}
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
{{< /highlight>}}
