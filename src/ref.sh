#!/bin/bash
# bash_notes function for editing reference file
# https://github.com/Magnushhoie/bash_notes

# DESC: Main control flow
function main() {
    script_init "$@"
    parse_params "$@"
    ref "$@"
}

function script_init() {
    function realpath() {
    [[ $1 = /* ]] && echo "$1" || echo "$PWD/${1#./}"
    }
    readonly script_path="${BASH_SOURCE[0]}"
    readonly script_name="$(basename "$0")"
    readonly script_dir="$(cd "$(dirname "$script_path")" && pwd -P)"
    readonly main_dir=$(dirname $script_dir)
    readonly script_params="$*"

    # Read in notes_folder and primary_note_file. By default ~/_bash_notes/ and ~/_bash_notes/references.txt
    source $main_dir/config.txt

    # Read in helper scripts.
    source $script_dir/functions.sh
}

# DESC: Usage help
function script_usage() {
    cat << EOF
usage: $script_name [notefile] keywords
  notefile: File basename in note folder if existing. Default is references.txt
  keywords: Search terms, space-separated

Optional arguments:
  -l|--list                  Displays searchable files in notes folder
  -a|--all                   Search across all files in notes folder
  -g|--get                   Get filenames and line-numbers for lines matching keywords across all files
  -h|--help                  Displays this help
  --open                     Open file with default system editor
  --config                   Open configuration file

Example usage:
View main note file:
ref 

Search main note file for keywords "bash" "loop"
ref bash loop

Search file newfile.txt in note folder for keywords "python"
ref newfile python

Search across all files in note folder for keywords "python" "list"
ref -a python list
EOF
}



# Run script
if ! (return 0 2> /dev/null); then
    main "$@"
fi
