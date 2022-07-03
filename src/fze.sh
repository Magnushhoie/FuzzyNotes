#!/bin/bash
# FuzzyNotes function for editing note files
# https://github.com/Magnushhoie/FuzzyNotes

# DESC: Main control flow
function main() {
    script_init "$@"

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
    fze "$@"
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
    action="edit"
}

# DESC: Usage help
function script_usage() {
    cat << EOF
usage: $script_name [notefile] keywords
  notefile: File basename in note folder if existing. Default is main.txt
  keywords: Search terms, space-separated

Optional arguments:
     -o|--open                  Open file with default system editor
     -l|--list                  Displays searchable files in notes folder
     -n|--new                   Create [filename] in notes folder
     -h|--help                  Displays this help
     --config                   Open configuration file
     --tutorial                 Start fze tutorial

Example usage:
Interactively search and edit files at lines starting with __ or #:
fze -f

Open and edit [main.txt] at first line with "bash loop"
fze bash loop

Create newfile.txt in notes folder
fze -n newfile.txt

Open newfile.txt at first line with "python"
fze newfile python
EOF
}

# Run script
if ! (return 0 2> /dev/null); then
    main "$@"
fi
