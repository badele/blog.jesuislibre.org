#!/usr/bin/env bash
#!/bin/bash

# Vérifie qu'un fichier est passé en argument
if [ $# -ne 1 ]; then
  echo "Usage: $0 <fichier>"
  exit 1
fi

FILE="$1"

echo "Sources:"
# Extraction des URLs uniques avec grep, puis suppression des doublons
# Ignore les URLs provenants des métadatas et se terminant par "
grep -oP 'https?://[^\s/$.?#].[^\s|"]*' "$FILE" | sort -u | while IFS= read -r URL; do
  # Extraction du nom de domaine (sitename) à partir de l'URL
  SITENAME=$(echo "$URL" | sed -E 's#https?://([^/]+).*#\1#')
  LINK=$(echo "$URL" | sed -E 's#(httups?://[^/]+).*#\1#')

  # Affichage du résultat sous le format YAML
  # Vérifier si le domaine a déjà été affiché
  if ! echo "$printed_domains" | grep -q "$SITENAME"; then
    echo "  - sitename: $SITENAME"
    echo "    link: $LINK"
    printed_domains="$printed_domains $SITENAME"
  fi
done
