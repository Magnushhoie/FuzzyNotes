#!/bin/bash
# bash_notes helper functions, called from ref.sh or refe.sh
# https://github.com/Magnushhoie/bash_notes

# Emulate BASH if using zsh
#if [ -n "$ZSH_VERSION" ]; then emulate -L ksh; fi

# Read in notes_folder and primary_note_file. By default ~/_bash_notes/ and references.txt
source $main_dir/config.txt

# Check that the default note file exists
if ! [[ -f $primary_note_file ]]
then
    echo "$primary_note_file does not exist. Please run $main_dir/setup.sh"
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
            -a | --all)
                search_all "$@"
                exit 0
                ;;
            -g | --get-file-line)
                get_file_line "$@"
                exit 0
                ;;
            -l | --list)
                list_files
                exit 0
                ;;
            -n | --new)
                create_new_file "$@"
                exit 0
                ;;
            --open)
                open_default "$@"
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

# DESC: Search script
function ref()
{
    filename=$primary_note_file

     # Check for alternative filename as first argument
     # If so, shift arguments so second+ becomes keyword
     alternative_filename=$(get_notefile $1)

     if [ $filename != "$alternative_filename" ];
         then filename=$alternative_filename
         shift
     fi

     echo $filename
     search_file $filename ${@:-"\s"}
}

# DESC: Edit script
function refe() # Search and edit references.txt in vim
{
# Opens up EDTIOR (vim) at first mention of keyword(s)
# Notefile is references.txt, unless another file found from first argument
     filename=$(get_notefile)

     # Check for alternative filename as first argument
     # If so, shift arguments so second+ becomes keyword
     alternative_filename=$(get_notefile $1)
     if [ $filename != $alternative_filename ];
         then filename=$alternative_filename
         shift
     fi

     echo $filename

    if [ $EDITOR == "vim" ];
        then
        # If keywords are not empty, try to search
        if ! [ -z $1 ];
            then vim +":set hlsearch" +/$1.*$2.*$3.*$4.*$5.*$6 $filename
            # Else open vim without search
        else vim "$filename"
        fi
    else
        # Open with alternative editor if not vim
        $EDITOR "$filename"
    fi
}

search_all() # Searches across all files in note directory.
{
    tmpfile=$(mktemp /tmp/abc-script.XXXXXX)
    cat $notes_folder/*.* > $tmpfile
    search_file $tmpfile ${@:-""}
}

get_file_line() # Finds filename and linenumber for given line search
{
    grep -in --color=always "$(echo $@)" $notes_folder/*.* | less -R
}

list_files() # List available files in note directory
{
    echo -e "Available files in $notes_folder"
    ls -lht $notes_folder/*.*
    echo -e "\nExample usage: ref [filename (excluding extension)] [keywords]"
}

create_new_file() # Opens requested note file using editor
{
    filename=$notes_folder/$1
    echo $filename
    $EDITOR $filename
}

open_default() # Opens requested note file in system default editor
{
    filename=$(get_notefile "$1")
    echo $filename
    open -t $filename
}

edit_config() # Opens configuration file in system default editor
{
    open -t $main_dir/config.txt
}

get_notefile() # Helper function for ref/refe functions
{
# Searches note folder for notefile. Default is references.txt
# Alternative name given if first argument matches that basename excluding file extension
# List of available files given if first argument is "list"

    # Modify these three to change default file or folder
    firstword=${1:-"references"}

    # Search for files in reference folder
    files=($notes_folder/*.*)
    #files=$(ls *.{txt,md} 2>/dev/null)
    #files=$(ls -p $notes_folder/* | grep -v /)

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
  GREP_COLOR='01;31' grep -Ein --color=always -C 20 "${2:-''}" "$filename" |
  # Successively different color for each successive search term
  GREP_COLOR='01;35' grep -Ei --color=always -C 10 "$3" |
  GREP_COLOR='01;93' grep -Ei --color=always -C 10 "$4" |
  GREP_COLOR='03;36' grep -Ei --color=always -C 10 "$5" |
  GREP_COLOR='03;34' grep -Ei --color=always -C 10 "$6" |
  GREP_COLOR='01;34' grep -Ei --color=always -C 10 "$7" |
  # Order lines to help with removal of empty -- lines
  sort -n |
  # Ensure all line-number lines are separated by "-"
  sed -E -e 's/:|-/-/' |
  # Keep only unique lines
  uniq |
  # Remove line numbers
  cut -d'-' -f2- |
  # Display in less with colors
  less -R
}
