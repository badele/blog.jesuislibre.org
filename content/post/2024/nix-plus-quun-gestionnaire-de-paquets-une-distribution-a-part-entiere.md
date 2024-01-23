---
Draft: False
Date: 2024-01-23
Title: "Nix : Plus qu'un gestionnaire de paquets, une distribution à part entière"
SubTitle: Partagez votre environnement de développement sans couac.
Section: Informatique
Tags:
- Blog
- DevOps
- Developpement
- NixOS
- Opensource
- planet-libre
Image: "/img/2024/nixos_logo.png"
BigImg:
- {src: "/img/2024/nixos_logo.png", desc: "NixOS Logo"}
---

## Intro

Après 15 années d'expérience avec Arch Linux, je suis maintenant un fervent
utilisateur de **NixOS**, que je considère comme ma distribution de prédilection.
Cependant, il est essentiel de noter que **NixOS** présente une courbe
d'apprentissage assez abrupte, surtout pour ceux qui ne sont pas familiers
avec la programmation fonctionnelle(Ce qui a été mon cas). 

Malgré cela, **Nix** offre l'avantage de pouvoir être installé sur toutes les
distributions grâce à son gestionnaire de paquets. 

Dans cet article, je vais vous guider à travers le processus d'installation
de **Nix** et vous fournir quelques exemples d'utilisation, particulièrement adaptés
à vos projets de developpement.

## Nix/NixOs c'est quoi ?

**Nix**, c'est un gestionnaire de paquets traditionnel, tel que ceux que l'on
trouve dans de nombreuses distributions Linux. Il est conçu pour gérer
l'installation, la mise à jour et la suppression de logiciels sur
un système d'exploitation donné. 

Mais il va bien au-delà, il introduit un concept révolutionnaire : 
la gestion de l'environnement entier du système de manière déterministe (immuable)

- **Le déterminisme** dans **Nix** permet de reproduire précisément
  un environnement logiciel sur une autre machine, garantissant ainsi
  la cohérence et la prévisibilité de chaque installation.
- **L'immuabilité** dans **Nix** implique que les paquets et les configurations
  sont fixes, ne pouvant pas être modifiés après leur création.
  Les mises à jour créent de nouvelles versions pour préserver la stabilité
  des autres logiciels du système.

Voici comment **Nix** se distingue :

1. **Gestion des Paquets immuable :** **Nix** adopte une approche 
fonctionnelle pour gérer les paquets. Cela signifie que chaque paquet est 
défini de manière immuable avec toutes ses dépendances(les dépendences
sont liées), de sorte que vous pouvez avoir plusieurs versions d'un même
logiciel en cours d'exécution sans conflits. De plus, les paquets sont isolés
les uns des autres, ce qui garantit une meilleure stabilité.

2. **Reproductibilité :** Avec **Nix**, vous pouvez reproduire précisément un
environnement logiciel donné sur n'importe quelle machine.
Cela rend les déploiements plus fiables, car vous pouvez être sûr que chaque
système utilisera la même configuration, éliminant ainsi les surprises liées
aux différences entre les machines.

3. **Distribution NixOS :** **Nix** ne se contente pas de gérer les paquets,
il offre également une distribution Linux complète appelée **NixOS**. 
**NixOS** est construit autour des principes de **Nix** et propose une configuration
système déclarative. Vous décrivez simplement la configuration que vous
souhaitez, et **NixOS** la rend possible de manière cohérente.

4. **Rolling Release :** **NixOS** suit un modèle de publication en continu,
ce qui signifie que vous bénéficiez toujours des dernières mises à jour
logicielles sans avoir à effectuer des mises à niveau majeures.
Cela simplifie la maintenance du système.

En résumé, **Nix** va au-delà de la gestion des paquets traditionnelle en offrant
une approche déterministe et fonctionnelle de la gestion de l'environnement
logiciel.

De plus, il propose une distribution complète, **NixOS**, qui intègre ces principes
pour offrir une expérience système plus cohérente et prévisible.
Que vous soyez un utilisateur avancé ou que vous
cherchiez simplement à améliorer la gestion de vos logiciels,
**Nix** mérite certainement votre attention.

Dans ce billet, je vais vous montrer comment utiliser **Nix** sur votre
distribution favorite, et comment l'utiliser dans le cadre de vos projets.

## Installation et utilisation de **Nix** sur votre distribution

Générallement **Nix** est disponible dans votre distribution, si ce n'est pas le
cas, vous pouvez l'installer avec les 2 lignes suivantes.

```shell
# linux/windows
sh <(curl -L https://nixos.org/nix/install) --daemon
grep 'experimental-features' /etc/nix/nix.conf || (echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf)

# macos 
sh <(curl -L https://nixos.org/nix/install)
grep 'experimental-features' /etc/nix/nix.conf || (echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf)
```
## Création d'un environement isolé

> Une particularité de **Nix** et qui porte à confusion,
c'est qu'ils ont des commandes **légacy** et des nouvelles commandes,
elles ont principallement les mêmes noms, mais séparé par un tiret (**-**).

#### Le shell

Imaginons que nous désirons developper un petit programme réseau en **C++**
qui inclu les librairies **boost** et **poco** et que nous voulions le
partager avec les autres contributeurs du projet.

Pour cela nous allons créer ce que j'appellerais un onboarding du projet, pour
cela il existe plusieurs manière de créer ce onboarding.

- **legacy mode**

Si l'on participe occasionellement au projet, on peut saisir la commande
suivante :

`nix-shell -p nix-shell -p gcc boost poco` (utilise le nix-channel). Utile
quand vous voullez tester des nouveaux outils. Les logiciels sont disponibles
seulement sur votre sessions bash en cours.

Ou inclure dans le projet le fichier `shell.nix` et par la suite, lorsque
vous voullez contribuer au projet, de saisir la commande `nix-shell`.
Pour un projet, priviliègiez cette méthode.

```nix
with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "cpp-environment";
  buildInputs = with pkgs; [ gcc boost poco ];
}
```

- **new shell mode**

`nix shell nixpkgs#gcc nixpkgs#boost nixpkgs#poco` (utilise le registry)

- **developpement mode**

Ou inclure le fichier `flake.nix` dans votre projet et lancer
la commande `nix develop` (**c'est ma méthode préféré**)

```nix
{
  description = "your-project-name development environement";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = with pkgs;
          mkShell {
            name = "Default developpement shell";
            packages = [ gcc boost poco ];
          };
      });
}
```

Vous pouvez avoir plus d'informations sur les options du fichier `flake.nix` à
[l'adresse suivante](https://nixos.wiki/wiki/Flakes)

## Démarer un projet clef en main

J'ai crée un projet **Nix** qui permet de démarer un projet avec les fonctions
suivantes :
- Installation des packages prérequis par le language de ce projet
- Installation des packages pour faire du **conventional commits**
- Installation de la CI github
  - Vérification du formatage de code
  - Execution des tests unitaires
  - Versioning et releasing automatique (en fonction des conventional commits)
- Vérification des commits avant validation du commit (pre-commit)

Imaginons que nous voulions créer un projet **deno/typescript** il suffit
d'effectuer : 

```shell
nix flake new -t "github:badele/nix-apps#deno" your-project-name
cd your-project-name
sh init_project
nix develop
```

Voila, vous pouvez dorénanvant travailler sur le projet.

## Astuces

- **Gestion des channels et registry**

**Nix** utilise des channels pour avoir sa liste des packages disponibles.
- **legacy**  
  - list: `nix-channel --list` 
  - update: `nix-channels --update nixpkgs`
- **new**
  - list: `nix registry list`
  - pin: `nix registry pin nixpkgs`
  - remove pined: `nix registry remove nixpkgs`

- **Afficher la version du channel**

```shell
NIXVERSION=$(nix-instantiate --eval -E '(import <nixpkgs> {}).lib.version')
NIXCOMMIT=$(echo $NIXVERSION | grep -oE "[a-z0-9]{12}")
DATEVERSION=$(curl -sL https://github.com/NixOS/nixpkgs/commit/$NIXCOMMIT | grep -oPm 1 datetime='"(.*?)T.*?"' | grep -oE "[0-9]+-[0-9]+-[0-9]+")
echo $DATEVERSION
```

Voila, j'espère que ce billet vous auras donné envie de découvrir **Nix**,
voire même de tester **NixOS**
