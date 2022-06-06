#!/bin/bash
# bash_ref function for editing reference file
# https://github.com/Magnushhoie/bash_ref

# DESC: Main control flow
function main() {
    script_init "$@"
    # Assign new notes_folder with -p [path]
    if [[ $1 = "-p" && -d "$2" ]]; then
      notes_folder="$2"
      shift
      shift
    fi

    parse_params "$@"
    ref "$@"
}

# DESC: Initialization parameters
function script_init() {
    script_path="${BASH_SOURCE[0]}"
    script_name="$(basename "$0")"
    script_dir="$(cd "$(dirname "$script_path")" && pwd -P)"
    main_dir=$(dirname "$script_dir")
    script_params="$*"

    # Read in notes_folder and primary_note_file. By default ~/_bash_ref/ and
    # ~/_bash_ref/main.txt
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
  notefile: File basename in note folder if existing. Default is main.txt
  keywords: Search terms, space-separated

Optional arguments:
  -o|--open                  Open file with default system editor
  -l|--list                  Display and open files in notes folder
  -g|--get                   Get filenames and line-numbers for lines matching keywords across all files
  -h|--help                  Displays this help
  --config                   Open configuration file
  --tutorial                 Start ref tutorial

Example usage:
Interactively search and view files for lines starting with __ or #:
ref

Search [main.txt] for keywords "bash" "loop"
ref bash loop

Search [python.py] in note folder for "list" "comprehension"
ref python list comprehension
EOF
}

# Run script
if ! (return 0 2> /dev/null); then
    main "$@"
fi
