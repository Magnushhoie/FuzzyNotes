#!/bin/bash
#set -o pipefail
IFS=$'\n\t'

# FuzzyNotes helper functions, called from fz.sh or fze.sh
# https://github.com/Magnushhoie/FuzzyNotes

# Emulate BASH if using zsh
#if [ -n "$ZSH_VERSION" ]; then emulate -L ksh; fi

# Read in notes_folder and primary_note_file. By default ~/_FuzzyNotes/ and main.txt
#source $main_dir/config.txt

#exclude_files="! -path '*.png' ! -path '*.jp*' ! -path '*.pdf' ! -path '*.ppt*' ! -path '*.doc*' ! -path '*.odt*' ! -path '*.gif'"
exclude_files="! -path '*.pdf'"

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
            -p | --path)
                # Pass, coded in fz.sh and fze.sh
                ;;
            -f | --full-search)
                full_search "open" "$@"
                exit 0
                ;;
            -g | --get-file-line)
                get_file_line "$@"
                exit 0
                ;;
            -l | --list)
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
function fz()
{
    # If no arguments, use interactive fzf_search instead
    if [ -z "$1" ]; then
        fzf_search
        exit 0
    fi

    #read -r filename filename_found <<<"$(get_notefile "$@")"
    read -r filename <<<"$(return_path_if_file_exists "$@")"

    if [[ $filename ]]; then
        shift
        echo "$filename"
        less -R "$filename"
        # Read filename and remaining arguments
        #fzf_search "$filename" "$@"
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
function fze() # Search and edit main.txt in vim
{
    # If no arguments, list available files
    if [ -z "$1" ]; then
        list_files_open
        exit 0
    fi

    read -r filename <<<"$(return_path_if_file_exists "$@")"

    if [[ "$filename" ]]; then
        if [[ $# = 1 ]]; then
            echo "$filename"
            vim +":silent! normal g;" +":set nonu" +":set nohlsearch"  "$filename"
            exit
        else
            echo "Search and editing $filename"
            vim +":silent! normal g;" +":set nonu" +":set hlsearch" +/"$2".*"$3".*"$4".*"$5".*"$6" "$filename"
            exit
        fi
    else
        # echo "No file found, please enter valid filename (without file extension)"
        list_files_open "$@"
        exit 0
    fi
}

function fzf_search ()
{
string2arg_file="$script_dir"/string2arg.sh
# Extract arguments
file="${1:-$notes_folder}"
# Shift to access rest of arguments
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
            | fzf -e --select-1 --preview="source $string2arg_file; string2arg $notes_folder/{}" --query "${query: }"
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
            | fzf -e --select-1 --preview="source $string2arg_file; string2arg $notes_folder/{}"
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

search_all() # Searches across all files in note directory.
{
    tmpfile=$(mktemp /tmp/FuzzyNotes_all.XXXXXX)
    cat "$notes_folder"/*.* > $tmpfile
    if ! [[ -s $tmpfile ]]; then
        search_file $tmpfile "${@:-""}"
    else
        echo "No search results, starting interactive search"
        fzf_search "$notes_folder" "$@"
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
    query="$@"
    #cd "$folder" || exit ; ls -t *.* | fzf -e --preview="bat $notes_folder/{}" | xargs -I {} less -Riw "$folder"/{}

    #export search_match=$(cd "$folder" || exit ; ls -tR *.* | fzf -e --preview="bat $notes_folder/{}" --query "${query: }")
    notes_folder=$(printf %q "$notes_folder")
    export search_match=$(cd "$folder" || 
                        exit ;
                        # ls -tR *.* |
                        # Find files, sort by time, search through symlinked
                        # directories,  remove leading ./ from find using sed
                        find -L . -maxdepth 5 -type f ! -path '.*/.*' ! -ipath '*.pdf' ! -ipath '*.png' ! -ipath '*.jp*' ! -ipath '*.xl*' ! -ipath '*.doc*' ! -ipath '*.pp*' -exec ls -t {} + |
                        sed 's/^.\///' |
                        fzf -e --select-1 --preview="bat {}" --query "${query: }")

    if [[ "$search_match" =~ [a-zA-Z0-9] ]]; then
        echo "$folder"/"$search_match"

        if [[ $action == "view" ]]; then
            less -Riw "$folder"/$search_match
        else
            vim +":silent! normal g;" +":set nonu" "$folder"/"$search_match"    
        fi
    fi

    #echo -e "\nExample usage: fz [filename (excluding extension)] [keywords]"
}

list_files_open_vim() # List available files in note directory
{
    folder=$notes_folder
    echo -e "Available files in $folder"
    query="$@"
    # fzf -e --preview="source $string2arg_file; string2arg $notes_folder/{}" --query "${query: }"
    export search_match=$(cd "$folder" || exit ; ls -t *.* | fzf -e --preview="bat $notes_folder/{}" --query "${query: }")

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

return_path_if_file_exists() # Helper function for fz/fze functions
{
    # Check if file exists in notefolder
    firstword=${1}

    # Search for files in main folder
    files=("$notes_folder"/*.*)

    # Look for alternative notefiles in folder if matches first argument
    for file in "${files[@]}"; do
        file_shorthand=$(basename "${file%%.*}")
        if [ "$file_shorthand" = "$firstword" ]; then
            echo $file
            shift
            break
        fi;
        done
}

get_notefile() # Helper function for fz/fze functions
{
# Searches note folder for notefile. Default is notes.txt
# Alternative name given if first argument matches that basename excluding file extension
# List of available files given if first argument is "list"

    # Modify these three to change default file or folder
    firstword=${1:-"notes"}

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
