---
Date: 2025-01-21
Title: "Faites le ménage de votre boite GMail en ligne de commande"
SubTitle: en utilisant les outils isync, mblaze et termgraph
Section: Informatique
Tags:
- Blog
- DevOps
- Opensource
- planet-libre
Image: "/img/2024/gmail_analyzer.png"
BigImg:
- {src: "/img/2024/gmail_analyzer.png", desc: "gmail analyzer"}
---

## Introduction

J'ai ouvert ma boite GMail en **2005**, récemment, GMail m’a alerté que ma boîte
mail avait atteint sa limite de 15 Go. Cela signifie qu’à court terme, je ne
pourrai ni envoyer ni recevoir d’emails. Bien que GMail propose une interface
efficace à bien des égards, il est quasiment impossible d’y gérer les emails par
taille (comme identifier les plus volumineux).

![gmail full](/img/2024/gmail_full.png) ![gmail 15go](/img/2024/gmail_15go.png)

Pour résoudre ce problème, j’ai décidé d’utiliser des outils en ligne de
commande afin d’analyser et de gérer mes emails. Voici les outils utilisés :

- **[isync](https://isync.sourceforge.io/mbsync.html)** (commande `mbsync`)
- **[mblaze](https://github.com/leahneukirchen/mblaze)**
- **[termgraph](https://github.com/mkaz/termgraph)**

---

## Préparation

### Installation des outils

Sous NixOS, les outils peuvent être installés avec la commande suivante :

```bash
nix shell nixpkgs#isync nixpkgs#mblaze nixpkgs#python312Packages.termgraph
```

Pour ceux qui ne sont pas sous NixOS, les outils sont disponibles via les
gestionnaires de paquets traditionnels.

### Configuration de GMail

Avant de commencer :

1. **Activez IMAP** depuis les paramètres de votre compte GMail :\
   [Configurer IMAP](https://mail.google.com/mail/u/0/#settings/fwdandpop)
2. **Générez un mot de passe pour les applications** :\
   [Créer un mot de passe application](https://myaccount.google.com/apppassword)

### Création du fichier de configuration pour isync

Créez un fichier `~/.config/isyncrc` pour configurer isync. Voici un exemple :

```ini
# Configuration générale
IMAPAccount perso
Host imap.gmail.com
User mon.email@gmail.com
PassCmd "pass show chemin/vers/mot/de/passe"
TLSType IMAPS
AuthMechs LOGIN

# Configuration des boîtes
IMAPStore perso-remote
Account perso

MaildirStore perso-local
SubFolders Verbatim
Path ~/.mail/perso/
Inbox ~/.mail/perso/Inbox

# Synchronisation
Channel perso
Far :perso-remote:
Near :perso-local:
Patterns "INBOX" "[Gmail]/Tous les messages"
Create Both
Expunge Both
```

Le mot de passe est ici stocké via l’outil **pass**. Plus d’informations :
[pass - The Standard Unix Password Manager](https://www.passwordstore.org/).

---

## Synchronisation des emails

Pour synchroniser votre boîte GMail avec un stockage local au format Maildir :

```bash
mbsync -n perso
```

---

## Analyse des emails

Une fois vos emails synchronisés, vous pouvez analyser leur contenu avec le
script suivant :

```bash
#!/usr/bin/env bash

OUTPUT_INFOS="sender_infos.txt"
OUTPUT_SUMMARIES="sender_summaries.txt"
ALLMAILS="$HOME/.mail/perso/[Gmail]/All Mail"

CURRENT=0

# Calcul de la taille des emails
mlist "${ALLMAILS}" | mseq -S

ALL_IDS=$(mseq)
TOTAL=$(echo "$ALL_IDS" | wc -l)

echo "" >"$OUTPUT_INFOS"
mseq | while read -r ID; do
    CURRENT=$((CURRENT + 1))
    PERCENT=$((CURRENT * 100 / TOTAL))
    echo -ne "Progress: $PERCENT% ($CURRENT/$TOTAL)\r"

    FROM=$(echo "$ID" | maddr -a -h "from")
    SUBJECT=$(mscan -f '%s' "$ID" | sed 's/;/ /g')
    SIZE=$(stat --format=%s "$ID")

    echo -e "${FROM};${SIZE};'${SUBJECT}';${ID}" >>"$OUTPUT_INFOS"
done
sort -t';' -rnk2 -o "$OUTPUT_INFOS" "$OUTPUT_INFOS"

awk -F ';' '{
    arr[$1]+=$2
} END {
    for (key in arr) printf("%s;%s\n", key, arr[key])
}' "$OUTPUT_INFOS" | sort -t';' -rnk2 >"$OUTPUT_SUMMARIES"
```

---

## Visualisation des résultats

Avec l’outil **termgraph**, vous pouvez afficher un graphique des expéditeurs
ayant envoyé les emails les plus volumineux :

```bash
termgraph --delim ';' sender_summaries.txt | head -n50
```

Exemple de sortie :

```text
valentine.tanguy@fake.mail                 : ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 1.62 B
leo.briere@fake.mail                       : ▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇▇ 706.63M
titouan.cornet@fake.mail                   : ▇▇▇▇▇▇▇▇▇▇▇▇▇ 437.38M
ismaël.adam@fake.mail                      : ▇▇▇▇▇▇▇▇▇▇ 329.93M
axel.vincent@fake.mail                     : ▇▇▇▇▇▇▇ 253.87M
charlie.larue@fake.mail                    : ▇▇▇▇▇▇▇ 253.65M
eliott.morin@fake.mail                     : ▇▇▇ 128.89M
titouan.lebel@fake.mail                    : ▇▇▇ 128.62M
nino.rey@fake.mail                         : ▇▇ 84.24M
mael.grandjean@fake.mail                   : ▇ 57.02M
rose.chevallier@fake.mail                  : ▇ 49.99M
léna.marcel@fake.mail                      : ▇ 49.40M
lyam.schaeffer@fake.mail                   : ▇ 46.12M
antonin.levy@fake.mail                     : ▇ 45.97M
zoé.yildiz@fake.mail                       : ▇ 44.08M
théo.jeanne@fake.mail                      : ▇ 43.80M
lenny.langlet@fake.mail                    : ▇ 35.81M
nino.beau@fake.mail                        : ▇ 35.71M
mathis.leray@fake.mail                     : ▏ 27.08M
louka.jan@fake.mail                        : ▏ 25.68M
clara.carrier@fake.mail                    : ▏ 25.08M
```

Pour explorer les pièces jointes d’un expéditeur spécifique :

```bash
grep "valentine.tanguy@fake.mail" sender_infos.txt | awk -F';' '{printf "%-20s;%-5s;%-40s\n", $1, int($2/1024/1024)"M", $3}' | column -t -s';'
```

```text
2025-01-12   valentine.tanguy@fake.mail  33M   Track cycling 
2025-01-12   valentine.tanguy@fake.mail  32M   Lunch meeting
2019-10-05   valentine.tanguy@fake.mail  32M   Photos 1
2020-09-19   valentine.tanguy@fake.mail  28M   Video 23
2025-01-12   valentine.tanguy@fake.mail  26M   All on bikes
2025-01-12   valentine.tanguy@fake.mail  25M   King's Trail / Geneva
2019-07-28   valentine.tanguy@fake.mail  24M   Photos leo
2025-01-12   valentine.tanguy@fake.mail  23M   Wasp sting
2017-12-25   valentine.tanguy@fake.mail  22M   Drawing software...
2016-08-22   valentine.tanguy@fake.mail  22M   Document supply
```

Après nettoyage, j'ai récupéré 2 Go d'espace disque supplémentaire. Cela devrait
me donner un peu de répit avant d'avoir à refaire un nouveau nettoyage.

![gmail cleaned](/img/2024/gmail_cleaned.png)

## Conclusion

Avec ces outils, il est facile d’identifier les emails ou expéditeurs
responsables de la saturation de votre boîte GMail. Vous pouvez alors supprimer
ou archiver les messages les plus volumineux de manière ciblée.

Mes scripts sont disponibles sur
[mon dépôt GitHub](https://github.com/badele/awesome-scripts/tree/main/maildir_email_size_analyzer).

## Sources

- Site webs
  - [mail.google.com](https://mail.google.com)
  - [myaccount.google.com](https://myaccount.google.com)
  - [isync](https://isync.sourceforge.io/mbsync.html)
  - [mblaze](https://github.com/leahneukirchen/mblaze)
  - [termgraph](https://github.com/mkaz/termgraph)
  - [www.passwordstore.org](https://www.passwordstore.org)
  - [github.com/badele/awesome-scripts](github.com/badele/awesome-scripts)
- IA
  - openai
    - Reformulation des phrases et correction des fautes d'orthographes
