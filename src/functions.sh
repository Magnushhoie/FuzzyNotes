#!/bin/bash
# bash_ref helper functions, called from ref.sh or refe.sh
# https://github.com/Magnushhoie/bash_ref

# Emulate BASH if using zsh
#if [ -n "$ZSH_VERSION" ]; then emulate -L ksh; fi

# Read in notes_folder and primary_note_file. By default ~/_bash_ref/ and main.txt
#source $main_dir/config.txt

# Check that the default note file exists
if ! [[ -f "$primary_note_file" ]]
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
            -f | --full-search)
                notes_folder=${1:-$notes_folder}
                full_search "open" "$@"
                exit 0
                ;;
            -g | --get-file-line)
                get_file_line "$@"
                exit 0
                ;;
            -l | --list)
                notes_folder=${1:-$notes_folder}
                list_files_open "$@"
                exit 0
                ;;
            -n | --new)
                create_new_file "$@"
                exit 0
                ;;
            -o | --open)
                open_default "$@"
                exit 0
                ;;
            -s | --stats)
                get_stats "$@"
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
    # If no arguments, use interactive fzf_search instead
    if [ -z "$1" ]; then
        fzf_search "view"
        exit 0
    fi

    read -r filename filename_found <<<"$(get_notefile "$@")"

    if [[ $filename_found = "TRUE" ]]; then
        shift
        # Read filename and remaining arguments
        fzf_search "view" "$filename" "$@"
        #if [[ $# = 1 ]]; then
        #    echo "Searching $filename"
        #    #less -R "$filename"
        #    fzf_search "$filename"
        #else
        #    echo "Searching $filename"
        #    search_file "$filename" "${@:-"\s"}"
        #fi
    else
        echo "Searching all files"
        search_all "$@"
    fi
}

# DESC: Edit script
function refe() # Search and edit main.txt in vim
{
    # If no arguments, list available files
    if [ -z "$1" ]; then
        list_files_open_vim
        exit 0
    fi

    read -r filename filename_found <<<"$(get_notefile "$@")"

    if [[ $filename_found = "TRUE" ]]; then
        if [[ $# = 1 ]]; then
            echo "Editing $filename"
            vim +":silent! normal g;" +":set nonu" +":set nohlsearch"  "$filename"
        else
            echo "Search and editing $filename"
            vim +":silent! normal g;" +":set nonu" +":set hlsearch" +/"$2".*"$3".*"$4".*"$5".*"$6" "$filename"
        fi
    else
        echo "No file found, please enter valid filename (without file extension)"
        list_files_open_vim "$@"
        exit 0
    fi
}

function fzf_search ()
{
string2arg_file="$script_dir"/string2arg.sh
echo $@
# Extract arguments
action="$1"
file="${2:-$notes_folder}"
# Shift to access rest of arguments
shift
shift
query="$@"

# Search for lines starting with "__" or "#", show filepaths for results
# Only show filepath relative to notes_folder, using ; as sed de-limiter
# Preview matching lines in file using fzf with custom string2arg function and bat
local search_match

# Open notes_folder if no filenames provided
export search_match=$(
            grep -I --exclude-dir="\.git" --color=always -rHn -e "^_" -e "^#" -e '^\\' "$file" \
            | sed "s;$notes_folder/;;" \
            | fzf -e --preview="source $string2arg_file; string2arg $notes_folder/{}" --query "${query: }"
            )

if [[ "$search_match" =~ [a-zA-Z0-9] ]]; then
    echo "$notes_folder"/"$search_match"
    # Extract filename from search_match
    vfile=$(cut -d":" -f1 <<< "$search_match")
    # Append path of notes_folder to get full path
    vfile="$notes_folder/$vfile"
    # Get line-number for match
    linematch=$(cut -d":" -f2 <<< "$search_match")

    if [[ $action = "view" ]]; then
        # Open file in less at matching line-number
        less -Riw +"$linematch" "$vfile"
        exit 0
    else
        # Open file in vim at matching line-number
        vim +":silent! normal g;" +":set nonu" +"$linematch" "$vfile"
        exit 0
    fi

fi
}

function full_search ()
{
local search_match
export search_match=$(
            grep -I --exclude-dir="\.git" --color=always -rHn -e "^\S" "$notes_folder" \
            | sed "s;$notes_folder/;;" \
            | fzf -e --preview="source $string2arg_file; string2arg $notes_folder/{}"
            )

if [[ "$search_match" =~ [a-zA-Z0-9] ]]; then
    echo "$notes_folder"/"$search_match"
    # Extract filename from search_match
    vfile=$(cut -d":" -f1 <<< "$search_match")
    # Append path of notes_folder to get full path
    vfile="$notes_folder/$vfile"
    # Get line-number for match
    linematch=$(cut -d":" -f2 <<< "$search_match")

    less -Riw +"$linematch" "$vfile"
    exit 0
fi
}

search_all() # Searches across all files in note directory.
{
    tmpfile=$(mktemp /tmp/bash_ref_all.XXXXXX)
    cat "$notes_folder"/*.* > $tmpfile
    if ! [[ -s $tmpfile ]]; then
        search_file $tmpfile "${@:-""}"
    else
        echo "No search results, starting interactive search"
        fzf_search "view" "$notes_folder" "$@"
    fi
}

get_file_line() # Finds filename and linenumber for given line search
{
    grep -in -I --exclude-dir="\.git" --color=always "$@" "$notes_folder"/*.* | less -Riw
}

list_files_open() # List available files in note directory
{
    folder=$notes_folder
    echo -e "Available files in $folder"
    cd "$folder" || exit ; ls -t *.* | fzf | xargs -I {} less -Riw "$folder"/{}
    #echo -e "\nExample usage: ref [filename (excluding extension)] [keywords]"
}

list_files_open_default() # List available files in note directory
{
    folder=$notes_folder
    echo -e "Available files in $folder"
    cd "$folder" || exit ; ls -t *.* | fzf | xargs -I {} open "$folder"/{}
    #echo -e "\nExample usage: ref [filename (excluding extension)] [keywords]"
}

list_files_open_vim() # List available files in note directory
{
    folder=$notes_folder
    echo -e "Available files in $folder"
    query="$@"
    export search_match=$(cd "$folder" || exit ; ls -t *.* | fzf --query "${query: }")

    if [[ "$search_match" =~ [a-zA-Z0-9] ]]; then
        vim +":silent! normal g;" +":set nonu" "$folder"/"$search_match"
        echo "$folder"/"$search_match"
    fi
}

create_new_file() # Opens requested note file using editor
{
    filename="$notes_folder/$1"
    touch "$filename"
    echo "$filename"
    open -t "$filename"
}

open_default() # Opens requested note file in system default editor
{
    # Open notes_folder if no filenames provided
    if [[ -z "$*" ]]; then
        echo "Opening $notes_folder"
        open $notes_folder
        exit 0
    fi

    # Sanity check that not trying to open more than 10 files
    if [[ $# -gt 10 ]]; then
        echo "$@"
        echo "Trying to open more than 10 files. Are you sure?"
        exit 0
    fi

    # Loop over multiple possible input files
    #echo "Trying to open multiple files from \"$*\""
    for pattern in "$@"; do
        read -r filename filename_found <<<"$(get_notefile $pattern)"
        echo "$pattern -> $filename"
        open -t "$filename"
    done
    exit 0
}

count_character() # Helper function to count characters
{
    file="$1"
    char="$2"
    echo $(grep "^$char" $file | wc -l | awk '{print $1}')
}


get_stats()
{
    #ls -ltr "$notes_folder"/*
    echo "Total lines for files in $notes_folder/"
    file=$(wc -l "$notes_folder"/*.* | sort -hr | tail -n +2 | fzf -e | awk '{print $2}')
    echo
    echo $(ls -lh $file)
    echo "Total lines - " $(count_character $file '')
    echo "Searchable lines starting with # -" $(count_character $file '#')
    echo "Searchable lines starting with _ -" $(count_character $file '_')
}

edit_config() # Opens configuration file in system default editor
{
    open -t "$main_dir"/config.txt
}

tutorial() # Opens configuration file in system default editor
{
    chmod 755 "$script_dir"/tutorial.sh
    "$script_dir"/tutorial.sh
}

get_notefile() # Helper function for ref/refe functions
{
# Searches note folder for notefile. Default is main.txt
# Alternative name given if first argument matches that basename excluding file extension
# List of available files given if first argument is "list"

    # Modify these three to change default file or folder
    firstword=${1:-"main"}

    # Search for files in main folder
    files=("$notes_folder"/*.*)

    # Look for alternative notefiles in folder if matches first argument
    notefile_found="FALSE"
    for file in "${files[@]}"; do
        file_shorthand=$(basename "${file%%.*}")
        if [ "$file_shorthand" = "$firstword" ]; then
            notefile=$file
            notefile_found="TRUE"
            shift
            break
        fi;
        done

    if [ -z "$notefile" ]; then
        notefile="$primary_note_file"
    fi

    echo "$notefile $notefile_found"
}

search_file() # Main search function using colored grep
{
filename="$1"
  # Grep with specific color, insensitive search with line-numbers on note file
  GREP_COLOR='01;31' grep -Ein -I --exclude-dir="\.git" --color=always -C 20 "${2:-''}" "$filename" |
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
  less -Riw
  exit 0
}
