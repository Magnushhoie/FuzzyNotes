#!/bin/bash
#set -o pipefail
IFS=$'\n\t'
# FuzzyNotes function for editing note files
# https://github.com/Magnushhoie/FuzzyNotes

# DESC: Main control flow
function main() {
    script_init "$@"
    # Assign new notes_folder with -p [path]
    if [[ $1 = "-p" && -d "$2" ]]; then
      notes_folder="$2"
      shift
      shift
    elif [[ $1 = "--path" && -d "$2" ]]; then
      notes_folder="$2"
      shift
      shift
    fi

    parse_params "$@"
    fz "$@"
}

# DESC: Initialization parameters
function script_init() {
    script_path="${BASH_SOURCE[0]}"
    script_name="$(basename "$0")"
    script_dir="$(cd "$(dirname "$script_path")" && pwd -P)"
    main_dir=$(dirname "$script_dir")
    script_params="$*"

    # Read in notes_folder and primary_note_file. By default ~/_FuzzyNotes/ and
    # ~/_FuzzyNotes/main.txt
    source "$main_dir"/config.txt

    # Read in helper scripts.
    source "$script_dir"/functions.sh

    # Set action, viewing or editiing
    action="view"
}

# DESC: Usage help
function script_usage() {
    cat << EOF
usage: $script_name [notefile] keywords
  notefile: File basename in note folder if existing. Default is notes.txt
  keywords: Search terms, space-separated

Optional arguments:
  -o|--open                  Open file with default system editor
  -l|--list                  Display and open files in notes folder
  -g|--get                   Get filenames and line-numbers for lines matching keywords across all files
  -h|--help                  Displays this help
  --config                   Open configuration file
  --tutorial                 Start fz tutorial

Example usage:
Interactively search and view files for lines starting with __ or #:
fz

Search [notes.txt] for keywords "bash" "loop"
fz bash loop

Search [python.py] in note folder for "list" "comprehension"
fz python list comprehension
EOF
}

# Run script
if ! (return 0 2> /dev/null); then
    main "$@"
fi
