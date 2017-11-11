---
Date: 2013-04-16
Title: Vérifiez vos dépôts git en une seule passe.
Section: Informatique
Aliases: /2013/4/16/verifiez-vos-depots-git-en-une-seule-passe
Tags:
- planet-libre
- Github
- Python
- Git
---

Utilisation
-----------

**Commande**

Pour l'utiliser, rien de plus simple

{{< highlight bash>}}
cd /usr/local/bin
wget https://raw.github.com/badele/gitcheck/master/gitcheck.py
chmod 755 gitcheck.py
gitcheck.py
ou
gitcheck.py -v
{{< /highlight>}}

**Version simplifiée**

Exemple d'utilisation en version simple.

![gitcheck](/img/2013/gitcheck.png)

Cette version affiche l'ensemble de vos dépôts git avec une mise en
évidence de l'état du projet, en vert les dépôts git non modifiés, en
rose les dépôts git modifiés.

**Version verbale**

![gitcheck en mode verbose](/img/2013/gitcheck_verbose.png)

La version verbose, indique en sus de la version précédente les fichiers
modifiés en orange.

**Les sources**

Les sources du script sont disponibles sur le dépot github
<https://github.com/badele/gitcheck>
