# coding=utf8
import re
import sys

links = {}


# Fonction pour extraire les URLs et les afficher avec les sitenames uniques
def extract_unique_links(filename):
    global unique_links

    # https://regex101.com/r/fLD6d8/1
    url_pattern = re.compile(r'https?:\/\/[^\s\)"]+')
    domainurl_pattern = re.compile(r"https?:\/\/[^/]+")

    breakcount = 0
    try:
        with open(filename, "r") as file:
            for line in file:
                if line == "---\n":
                    breakcount += 1

                # On est dans le block yaml du billet
                if breakcount < 2:
                    continue

                # Trouver toutes les correspondances de liens dans la ligne
                url_matches = url_pattern.findall(line)

                for url in url_matches:
                    # Extraire le nom de domaine (sitename) de l'URL
                    domainurl_matches = domainurl_pattern.findall(url)
                    domainname = re.sub(r"^https?://", "", url).split("/")[0]

                    if domainname not in links:
                        links[domainname] = [domainurl_matches[0]]

                    if url not in links[domainname]:
                        links[domainname].append(url)

        # Afficher le résultat sous forme YAML
        print("Sources:")
        for domain in links:
            print(f"  - sitename: {domain}")
            count = len(links[domain])
            if count == 2:
                print(f"    link: {links[domain][1]}")
            else:
                print(f"    link: {links[domain][0]}")

        # for sitename, url in unique_links.items():
        #     print(f'  - sitename: "{sitename}"')
        #     print(f'    link: "{url}"')
    except FileNotFoundError:
        print(f"Erreur : Le fichier '{filename}' n'a pas été trouvé.")
        sys.exit(1)


# Vérification que le script est appelé avec un fichier en argument
if len(sys.argv) != 2:
    print("Usage : python extract_unique_links.py <fichier>")
    sys.exit(1)

# Appel de la fonction avec le fichier passé en argument
extract_unique_links(sys.argv[1])
