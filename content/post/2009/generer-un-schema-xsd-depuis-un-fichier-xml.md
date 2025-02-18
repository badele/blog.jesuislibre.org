---
Date: 2009-04-20T00:03:00
Title: Générer un schéma xsd depuis un fichier xml
Subtitle: Détaille comment générer un schéma xsd depuis un fichier xml
Section: Informatique
Aliases: /2009/4/20/generer-un-schema-xsd-depuis-un-fichier-xml
Tags:
- planet-libre
- Archlinux
- Outil
- Terminal
- Tutoriel
- XML
Sources:
  - sitename: fr.wikipedia.org
    link: https://fr.wikipedia.org/wiki/XML_Schema
  - sitename: archlinux.fr
    link: https://archlinux.fr/yaourt
  - sitename: www.allhtml.com
    link: https://www.allhtml.com
  - sitename: www.w3.org
    link: https://www.w3.org/2001/XMLSchema
---

Pour cela nous allons utiliser l’outil
[trang](Générer%20un%20schéma%20xsd%20depuis%20un%20fichier%20xml), outil
développé en Java, qui est donc multi-plateforme

## A propos

- [XML](XSD%20(Schema%20XML)%20Définit%20la%20structure%20d’un%20fichier%20XML)
  (Extensible Markup Language) Format de fichier permettant d’échanger des
  informations entre divers logiciels
- [XSD](http://fr.wikipedia.org/wiki/XML_Schema) (Schema XML) Définit la
  structure d’un fichier XML

## Installation et utilisation de trang

Je vais expliquer ici son utilisation et l’installation sur la distribution
Archlinux. Nous installons trang avec l’outil
[Yaourt](http://archlinux.fr/yaourt)

```bash
yaourt -S trang
```

Pour le fichier d’exemple, j’ai utilisé le fichier XML fourni dans le tutoriel
suivant <http://www.allhtml.com/articles/detail/354>

Copiez le fichier de l’ exemple suivant dans le fichier xml.xml

```xml
<?xml version="1.0"?>
<!-- Exemple issu du site  http://www.allhtml.com/articles/detail/354 -->
<traducteur>
  <mot>
    <francais>Bleu</francais>
    <english>Blue</english>
    <italiano>Azzurro</italiano>
  </mot>
  <mot>
    <francais>Rouge</francais>
    <english>Red</english>
    <italiano>Rosso</italiano>
  </mot>
  <mot>
    <francais>Vert</francais>
    <english>Green</english>
    <italiano>Verde</italiano>
  </mot>
</traducteur>
```

Ensuite lancez la commande suivante:

```bash
trang xml.xml xml.xsd
```

Et voici le résultat

```xml
<?xml version="1.0" encoding="UTF-8"?>
  <xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema" elementFormDefault="qualified">
  <xs:element name="traducteur">
    <xs:complexType>
      <xs:sequence>
        <xs:element maxOccurs="unbounded" ref="mot"/>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name="mot">
    <xs:complexType>
      <xs:sequence>
        <xs:element ref="francais"/>
        <xs:element ref="english"/>
        <xs:element ref="italiano"/>
      </xs:sequence>
    </xs:complexType>
  </xs:element>
  <xs:element name="francais" type="xs:NCName"/>
  <xs:element name="english" type="xs:NCName"/>
  <xs:element name="italiano" type="xs:NCName"/>
</xs:schema>
```
