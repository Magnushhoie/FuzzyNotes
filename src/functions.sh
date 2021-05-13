#!/bin/bash
# bash_notes helper functions, called from ref.sh or refe.sh
# https://github.com/Magnushhoie/bash_notes

# Read in notes_folder and primary_note_file. By default ~/_bash_notes/ and references.txt
source $main_dir/config.txt

# Check that the default note file exists
if ! [[ -f $primary_note_file ]]
then
    echo "$primary_note_file does not exist. Please run $script_dir/setup.sh"
fi


# Initialization functions

# DESC: Parameter parser
function parse_params() {
    local param
    while [[ $# -gt 0 ]]; do
        param="$1"
        shift
        case $param in
            -h | --help)
                script_usage
                exit 0
                ;;
            -l | --list)
                list_files
                exit 0
                ;;
            -n | --new)
                create_new_file $@
                exit 0
                ;;
            --open)
                open_default $@
                exit 0
                ;;
            --config)
                edit_config
                exit 0
                ;;
        esac
    done
}

# Scripts
list_files() # List available files in note directory
{
echo -e "Available files in $notes_folder"
ls -lht $notes_folder/*.txt
echo -e "\nExample usage: ref [filename (excluding .txt)] [keywords]"
}

create_new_file() # Opens requested note file in default editor
{
    filename=$notes_folder/$1
    if ! [ "${filename: -4}" == ".txt" ];
        then echo "New file" $filename "must end with .txt"
    else
        echo $filename
        $EDITOR $filename
    fi
}

open_default() # Opens requested note file in default editor
{
    filename=$(get_notefile "$1")
    echo $filename
    open -t $filename
}

edit_config() # Opens configuration file in default editor
{
    open -t $main_dir/config.txt
}

get_notefile() # Helper function for ref functions
{
# Searches note folder for notefile. Default is references.txt
# Alternative name given if first argument matches that basename excluding file extension
# New filename given if first argument ends in .txt
# List of available files given if first argument is "list"

    # Modify these three to change default file or folder
    firstword=${1:-"references"}

    # Search for .txt files in reference folder
    files=($notes_folder/*.txt)

    # Look for alternative notefiles in folder if matches first argument
    for file in ${files[*]}; do
        file_shorthand=$(basename "${file%%.*}")
        if [ "$file_shorthand" = $firstword ];
            then notefile=$file
        fi;
        done

    if [ -z "$notefile" ];
        then notefile=$primary_note_file
    fi

    echo $notefile
}

search_file() # Main search function using colored grep
{
filename=$1
  # Grep with specific color, insensitive search with line-numbers on note file
  GREP_COLOR='01;31' grep -in --color=always -C 20 ${2:-""} "$filename" |
  # Successively different color for each successive search term
  GREP_COLOR='01;35' grep -i --color=always -C 10 "$3" |
  GREP_COLOR='01;93' grep -i --color=always -C 10 "$4" |
  GREP_COLOR='03;36' grep -i --color=always -C 10 "$5" |
  GREP_COLOR='03;34' grep -i --color=always -C 10 "$6" |
  GREP_COLOR='01;34' grep -i --color=always -C 10 "$7" |
  # Order lines to get rid of -- matches
  sort -n |
  # Ensure all line-number lines are separated by -
  sed -E -e 's/:|-/-/' |
  # Keep only unique lines
  uniq |
  # Remove line numbers
  cut -d'-' -f2- |
  # Display in less with colors
  less -R
}