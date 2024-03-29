#!/bin/bash
# Sets up FuzzyNotes scripts as aliases and FuzzyNotes folder
# https://github.com/Magnushhoie/FuzzyNotes

# set -e

# Check requirements
if [[  $(command -v fzf) ]]; then
    echo -e "ERROR: FuzzyNotes requires fzf to run\nhttps://github.com/junegunn/fzf"
    echo -e "\nPlease install with:\nbrew install fzf"
    #exit 0
fi

script_path="${BASH_SOURCE[0]}"
script_dir="$(cd "$(dirname "$script_path")" && pwd -P)"

# To change the default notes folder, edit config.txt
# Reads in notes_folder and primary_note_file
source "$script_dir"/config.txt

# Make scripts executable
chmod 755 "$script_dir"/src/fz.sh
chmod 755 "$script_dir"/src/fze.sh

echo -e "Setting up notes folder in $notes_folder"

echo -e "Checking if $notes_folder exists"
if ! [ -d "$notes_folder" ]; then
    echo -e "Notes folder does not already exist ... Copying from $script_dir/_FuzzyNotes ..."
    cp -r "$script_dir"/_FuzzyNotes "$notes_folder"
fi

# If not sourced, ask whether to add aliases to bash_profile and set default editor
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    echo -e
    read -p "Automatically add aliases fz and fze to ~/.bash_profile and ~/.zshrc? y/n " -n 1 -r
    echo -e
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "\nAdding aliases to .bash_profile and ~/.zshrc ..."
        touch "$HOME"/.bash_profile
        touch "$HOME"/.zshrc

        LINE1=$(echo -e alias fz="$script_dir"/src/fz.sh)
        LINE2=$(echo -e alias fze="$script_dir"/src/fze.sh)
        BASH_FILE=$(echo -e "$HOME"/.bash_profile)
        ZSH_FILE=$(echo -e "$HOME"/.zshrc)
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
    sed -iE "s/EDITOR=.*/EDITOR=$NEW_EDITOR/" "$script_dir"/config.txt
    echo -e "Note: You can change your editor with fz --config or editing config.txt"
fi

echo -e "\nDone!"
echo -e "Please open a new terminal window or run source ~/.bash_profile"

echo -e
read -p "Run tutorial? y/n" -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]; then
    bash "$script_dir"/src/tutorial.sh
fi
echo "Tutorial can always be run with fz --tutorial"
