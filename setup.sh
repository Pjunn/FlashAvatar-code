#!/bin/bash
urle () { [[ "${1}" ]] || return 1; local LANG=C i x; for (( i = 0; i < ${#1}; i++ )); do x="${1:i:1}"; [[ "${x}" == [a-zA-Z0-9.~-] ]] && echo -n "${x}" || printf '%%%02X' "'${x}"; done; echo; }

# Fetch FLAME data
echo -e "\nBefore you continue, you must register at https://flame.is.tue.mpg.de/ and agree to the FLAME license terms."
read -p "Username (FLAME):" username
read -p "Password (FLAME):" password
username=$(urle $username)
password=$(urle $password)

echo -e "\nDownloading FLAME..."
wget --post-data "username=$username&password=$password" 'https://download.is.tue.mpg.de/download.php?domain=flame&sfile=FLAME2020.zip&resume=1' -O './flame/FLAME2020.zip' --no-check-certificate --continue
unzip ./flame/FLAME2020.zip -d ./flame/FLAME2020
mv ./flame/FLAME2020/generic_model.pkl ./flame

wget 'https://files.is.tue.mpg.de/tbolkart/FLAME/FLAME_masks.zip' -O './flame/FLAME_masks.zip' --no-check-certificate --continue
unzip ./flame/FLAME_masks.zip -d ./flame/FLAME_masks
