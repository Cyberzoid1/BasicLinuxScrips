#!/bin/bash

# This script sets up common user preferences

#echo "User is $USER with home dir: $HOME"

if [[ $EUID -eq 0 ]]; then
  echo "This script does not need root privleges. Run with normal privleges"
  exit
fi

# URL of Github gist where the alias is stored
GISTURL="https://gist.githubusercontent.com/Cyberzoid1/89ba686041208df8466f68d07931a208/raw/c668edcd67ffc6011d526cc2eb88f2c0a3609a4f/gistfile1.md"


echo "Setting up ${HOME}/.gitconfig"
if [ -f "${HOME}/.gitconfig" ]; then
  echo "Git config exists"
  if grep -Fxq "[alias]" "${HOME}/.gitconfig"
  then
    echo "[alias] already exists in .gitconfig"
  else
    echo "[alias] does not exist. Appending git alias's to .gitconfig"
    # Thank you for the simple answer: https://www.shellhacks.com/sed-awk-print-lines-between-two-patterns/
    # first sed printes between lines, second Sed removes deliminaters
    curl -s "${GISTURL}" | sed -n '/```/,/```/p' | sed  '/```/d' >> "${HOME}/.gitconfig"
  fi
else
  echo ".gitconfig does not exist. Creating.."
  read -p 'Git email: ' -r gituser
  read -p 'Git name: ' -r gitname
  echo "Appending git alias's from gist to .gitconfig"
  echo -e "[user]\n\temail = ${gituser}\n\tname = ${gitname}\n" > "${HOME}/.gitconfig"
  curl -s "${GISTURL}" | sed -n '/```/,/```/p' | sed  '/```/d' >> "${HOME}/.gitconfig"
fi



# Setup VIM escap key mapping
ESCMAP="imap jj <ESC>"
VIMLOC="$HOME/.vimrc"
echo -e "\nSetting up ${VIMLOC}"
if [ -f "$VIMLOC" ]; then
  echo "vim settings file $VIMLOC exists"
  if grep -Fxq "$ESCMAP" "$VIMLOC"
  then
    echo "$ESCMAP entry found"
  else
    echo "$ESCMAP entry not found. Appending to file"
	echo "$ESCMAP" >> "$VIMLOC"
  fi
else
  echo "vim settings file $VIMLOC does not exist. Creating with $ESCMAP entry."
  echo "$ESCMAP" >> "$VIMLOC"
fi



# Test and ask to make ssh key
# Doc: https://www.ssh.com/ssh/keygen/
echo -e "\nSetting up ssh keys"
SSHKEYNAME="id_rsa"
if [ ! -f "${HOME}/.ssh/${SSHKEYNAME}" ]; then
  read -p 'Do you wish to generate a ssh key? (y/N)' -r input
  echo  # Move to new line
  if [[ "${input}" =~ ^[Yy]$ ]]; then
    ssh-keygen -f "${HOME}/.ssh/${SSHKEYNAME}" -t rsa -b 4096
  fi
else
  echo "${SSHKEYNAME} already exists"
fi



# Ask if the user would like to transfer pub key to other servers & loop
echo  # Move to new line
read -p "Do you want to transfer ${SSHKEYNAME}.pub to another server? (y/N)" -r input
while [[ "${input}" =~ ^[Yy]$ ]]; do
  read -p 'Destination host (user@host): ' -r inputHost
  ssh-copy-id -i "${HOME}/.ssh/${SSHKEYNAME}" "${inputHost}"
  read -p "Do you want to transfer ${SSHKEYNAME}.pub to another server? (y/N)" -r input
done


echo "Personalized environment setup complete"