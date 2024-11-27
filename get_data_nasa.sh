#!/bin/bash

# URL de l'API Mars Rover
API_URL="https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos"
API_KEY="C1YI6YCxR1g1zc6cyGAAd2PGAFlXSXfaYVGGVZqz"  # Remplacez par votre propre clé API

# Paramètres pour la requête
SOL=1000  # Jour martien (SOL) pour récupérer les photos prises ce jour-là

# Faire la requête à l'API pour récupérer les photos
RESPONSE=$(curl --silent --request GET "$API_URL?sol=$SOL&api_key=$API_KEY")

# Vérifier si la réponse est valide
if [ -z "$RESPONSE" ]; then
  echo "Erreur : aucune réponse de l'API."
  exit 1
fi

# Vérifier si la réponse est au format JSON
echo "$RESPONSE" | jq . 2>/dev/null
if [ $? -eq 0 ]; then
  echo "Réponse JSON valide reçue :"
  echo "$RESPONSE" | jq .  # Afficher la réponse formatée
else
  echo "Erreur : réponse JSON invalide."
  echo "$RESPONSE"
  exit 1
fi

# Extraire les URL des images
IMG_URLS=$(echo "$RESPONSE" | jq -r '.photos[] | .img_src')

echo "URLs des photos prises par le Rover Curiosity (SOL $SOL) :"
echo "$IMG_URLS"
