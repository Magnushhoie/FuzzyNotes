#!/bin/bash
# Sets up bash_ref scripts as aliases and bash_ref folder
# https://github.com/Magnushhoie/bash_ref

set -e

readonly script_path="${BASH_SOURCE[0]}"
readonly script_dir="$(cd "$(dirname "$script_path")" && pwd -P)"

# To change the default notes folder, edit config.txt
# Reads in notes_folder and primary_note_file
source $script_dir/config.txt

# Make scripts executable
chmod 755 $script_dir/src/ref.sh
chmod 755 $script_dir/src/refe.sh

echo -e "Setting up notes folder in $notes_folder"
mkdir -p "$notes_folder"

echo -e "Checking if $primary_note_file exists"
if ! [ -f "$primary_note_file" ]; then
    echo -e "File does not already exist. Copying from $script_dir/references.txt ..."
    cp $script_dir/references.txt $primary_note_file
fi

# If not sourced, ask whether to add aliases to bash_profile and set default editor
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
    then
    echo -e
    read -p "Automatically add aliases ref and refe to ~/.bash_profile and ~/.zshrc? y/n " -n 1 -r
    echo -e
    if [[ $REPLY =~ ^[Yy]$ ]]
        then
        echo -e "\nAdding aliases to .bash_profile and ~/.zshrc ..."
        touch $HOME/.bash_profile
        touch $HOME/.zshrc

        LINE1=$(echo -e alias ref=$script_dir/src/ref.sh)
        LINE2=$(echo -e alias refe=$script_dir/src/refe.sh)
        BASH_FILE=$(echo -e $HOME/.bash_profile)
        ZSH_FILE=$(echo -e $HOME/.zshrc)
        grep -qF -- "$LINE1" "$BASH_FILE" || echo -e "$LINE1" >> "$BASH_FILE"
        grep -qF -- "$LINE2" "$BASH_FILE" || echo -e "$LINE2" >> "$BASH_FILE"

        grep -qF -- "$LINE1" "$ZSH_FILE" || echo -e "$LINE1" >> "$ZSH_FILE"
        grep -qF -- "$LINE2" "$ZSH_FILE" || echo -e "$LINE2" >> "$ZSH_FILE"
    fi

    # Pick main editor

    PS3='Please pick main text editor to use:'
    options=("system default for .txt files" "vim")
    select opt in "${options[@]}"
    do
        case $opt in
            "system default for .txt files")
                NEW_EDITOR=open
                echo -e "\nYou chose system default"
                break
                ;;
            "vim")
                NEW_EDITOR=vim
                echo -e "\nYou chose vim"
                break
                ;;
            *) echo "invalid option $REPLY";;
        esac
    done
    # Replace editor line in config.txt
    sed -iE "s/EDITOR=.*/EDITOR=$NEW_EDITOR/" $script_dir/config.txt
    echo -e "Note: You can change your editor with ref --config or editing config.txt"
fi

echo -e "\nDone!"
echo -e "Please open a new terminal window or run source ~/.bash_profile"
echo -e "To get started try ref (search) or refe (search and edit in Vim)"
