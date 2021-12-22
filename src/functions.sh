#!/bin/bash
# bash_ref helper functions, called from ref.sh or refe.sh
# https://github.com/Magnushhoie/bash_ref

# Emulate BASH if using zsh
#if [ -n "$ZSH_VERSION" ]; then emulate -L ksh; fi

# Read in notes_folder and primary_note_file. By default ~/_bash_ref/ and main.txt
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
            -f | --fzf)
                fzf_search "open" "$@"
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
            -o | --open)
                open_default "$@"
                exit 0
                ;;           
            --tutorial)
                tutorial "$@"
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
    filename=$(get_notefile $@)
    echo $filename

    # If no arguments other than filename, use interactive fzf_search instead
    if [ -z $1 ]; then
        fzf_search "view"
        exit 0
    fi

     # If first argument is not the primary notefile, shift shift arguments once so search-terms come first
     if [ "$filename" != $primary_note_file ]; then
        shift
        search_file $filename ${@:-"\s"}
        else
        search_all "$@"
     fi

}

# DESC: Edit script
function refe() # Search and edit main.txt in vim
{
# Opens up EDTIOR (vim) at first mention of keyword(s)
# Notefile is main.txt, unless another file found from first argument
    filename=$(get_notefile $@)

     # Check for alternative filename as first argument
     # If so, shift arguments so second+ becomes keyword
     if [ $filename != $primary_note_file ]; then
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

function fzf_search ()
{
action=$1
file=$2
string2arg_file="$script_dir"/string2arg.sh

# Search for lines starting with "__" or "#", show filepaths for results
# Only show filepath relative to notes_folder, using ; as sed de-limiter
# Preview matching lines in file using fzf with custom string2arg function and bat
local search_match
export search_match=$(
            grep --color=always -rHn -e "^__" -e "^#" "$notes_folder" \
            | sed "s;$notes_folder/;;" \
            | fzf -e --preview="source $string2arg_file; string2arg $notes_folder/{}")

if [[ $search_match =~ [a-zA-Z0-9] ]]; then
    echo $search_match
    # Extract filename from search_match
    vfile=$(cut -d":" -f1 <<< $search_match)
    # Append path of notes_folder to get full path
    vfile="$notes_folder"/"$vfile"
    # Get line-number for match
    linematch=$(cut -d":" -f2 <<< $search_match)

    if [[ $action = "view" ]]; then
        # Open file in less at matching line-number
        less +$linematch $vfile
        exit 0
    else
        # Open file in vim at matching line-number
        vim +$linematch $vfile
    fi

fi
}

search_all() # Searches across all files in note directory.
{
    tmpfile=$(mktemp /tmp/bash_ref_all.XXXXXX)
    cat $notes_folder/*.* > $tmpfile
    search_file $tmpfile ${@:-""}
    exit 0
}

get_file_line() # Finds filename and linenumber for given line search
{
    grep -in --color=always "$(echo $@)" $notes_folder/*.* | less -R
}

list_files() # List available files in note directory
{
    echo -e "Available files in $notes_folder"
    cd $notes_folder; ls -tr *.* | fzf | xargs -I {} open $notes_folder/{}
    #echo -e "\nExample usage: ref [filename (excluding extension)] [keywords]"
}

create_new_file() # Opens requested note file using editor
{
    filename=$notes_folder/$1
    touch $filename
    echo $filename
    open $filename
}

open_default() # Opens requested note file in system default editor
{
    # Sanity check that not trying to open more than 10 files
    if [ $# -gt 10 ]; then
        echo "$@"
        echo "Trying to open more than 10 files. Are you sure?"
        exit 0
    fi

    # Still open default file if input arguments are empty
    if [[ -z "$@" ]]; then
        filename=$(get_notefile $pattern)
        echo $filename
        open -t $filename
        exit 0
    fi

    # Loop over multiple possible input files
    for pattern in "$@"; do
        filename=$(get_notefile $pattern)
        echo "$pattern -> $filename"
        open -t $filename
    done
    exit 0
}

edit_config() # Opens configuration file in system default editor
{
    open -t $main_dir/config.txt
}

tutorial() # Opens configuration file in system default editor
{
    chmod 755 $script_dir/tutorial.sh
    $script_dir/tutorial.sh
}

get_notefile() # Helper function for ref/refe functions
{
# Searches note folder for notefile. Default is main.txt
# Alternative name given if first argument matches that basename excluding file extension
# List of available files given if first argument is "list"

    # Modify these three to change default file or folder
    firstword=${1:-"references"}

    # Search for files in reference folder
    files=($notes_folder/*.*)

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
  less -Ri
}
