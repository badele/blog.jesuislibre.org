public: yes
tags: [Archlinux, Outil, Planet-Libre, Terminal, Tutoriel, XML]
summary: |
  Détaille comment générer un schéma xsd depuis un fichier xml

Générer un schéma xsd depuis un fichier xml
===========================================

Pour cela nous allons utiliser l’outil `trang <Générer un schéma xsd depuis un fichier xml>`_, outil développé en Java, qui est donc multi-plateforme

A propos
--------

- `XML <XSD (Schema XML) Définit la structure d’un fichier XML>`_ (Extensible Markup Language) Format de fichier permettant d’échanger des informations entre divers logiciels
- `XSD <http://fr.wikipedia.org/wiki/XML_Schema>`_ (Schema XML) Définit la structure d’un fichier XML

Installation et utilisation de trang
------------------------------------

Je vais expliquer ici son utilisation et l’installation sur la distribution Archlinux. Nous installons trang avec l’outil `Yaourt <http://archlinux.fr/yaourt>`_

.. sourcecode:: bash

                yaourt -S trang

Pour le fichier d’exemple, j’ai utilisé le fichier XML fourni dans le tutoriel suivant http://www.allhtml.com/articles/detail/354

Copiez le fichier de l’ exemple suivant dans le fichier xml.xml

.. sourcecode:: xml

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

Ensuite lancez la commande suivante:

.. sourcecode:: bash

                trang xml.xml xml.xsd

Et voici le résultat

.. sourcecode:: xml

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
