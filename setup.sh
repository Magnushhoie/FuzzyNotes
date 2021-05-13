#!/bin/bash
# Sets up bash_notes scripts as aliases and bash_notes folder
# https://github.com/Magnushhoie/bash_notes

readonly script_path="${BASH_SOURCE[0]}"
readonly script_dir="$(realpath $(dirname "$script_path"))"

# To change the default notes folder, edit config.txt
# Reads in notes_folder and primary_note_file
source $script_dir/config.txt

# Make scripts executable
chmod 755 $script_dir/ref.sh
chmod 755 $script_dir/refe.sh

echo -e "Setting up notes folder in $notes_folder"
mkdir -p "$notes_folder"

echo -e "Checking if $primary_note_file exists"
if ! [ -f "$primary_note_file" ]; then
    echo -e "File does not already exist. Copying from $script_dir/references.txt ..."
    cp $script_dir/references.txt $primary_note_file
fi

echo -e
read -p "Automatically add aliases ref and refe to ~/.bash_profile? y/n " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
    then
    echo -e "\nAdding aliases to .bash_profile ..."

    LINE1=$(echo -e alias ref=$script_dir/ref.sh)
    LINE2=$(echo -e alias refe=$script_dir/refe.sh)
    FILE=$(echo -e $HOME/.bash_profile)
    grep -qF -- "$LINE1" "$FILE" || echo -e "$LINE1" >> "$FILE"
    grep -qF -- "$LINE2" "$FILE" || echo -e "$LINE2" >> "$FILE"
fi

echo -e "\nDone!"
echo -e "Please open a new terminal window or run source ~/.bash_profile"
echo -e "To get started try ref (search) or refe (search and edit in Vim)"