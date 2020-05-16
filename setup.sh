#!/bin/bash
echo "Bash note reference directory will be ~/_References/"

read -p "Automatically add source bash_notes.sh and fuzzy_commands.sh to .bash_profile? y/n " -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
    echo "Adding source to .bash_profile ..."
    script_dir=$(realpath $(dirname ${BASH_SOURCE[0]}))

    source_file=$script_dir/bash_notes.sh
    LINE=$(echo 'source' $source_file)
    FILE=$(echo $HOME/.bash_profile)
    grep -qF -- "$LINE" "$FILE" || echo "$LINE" >> "$FILE"

fi

read -p "Copy over vim configuration file? (Color highlighting of code, mouse support and other sane defaults...)  y/n? " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cp -r vim $HOME/.vim
    cp -r vimrc $HOME/.vimrc
fi

# Setting up references folder ...
echo "Setting up references folder in ~/_References/"
ref_folder=$HOME/_References
mkdir -p "$ref_folder"

FILE=$ref_folder/references.txt
if [ -f "$FILE" ]; then
    echo "$FILE exists"
else
    echo "$FILE does not exist. Creating new ..."
    cp references.txt $ref_folder/references.txt
fi

echo -e "\nDone! Please open a new terminal shell, or run source ~/.bash_profile"
echo -e "To get started try ref_help, ref (search) or refv (search and edit in Vim)"
echo "Note: To exit refv (Vim), press Escape then write :q   ... to save and exit write :wq   ... :w = write, :q = quit"
echo "Note: To exit ref \(less\) press q ... q = quit." 
echo "For overview of commands write ref_help or help"
