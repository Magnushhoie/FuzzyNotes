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
    readonly script_dir="$(cd "$(dirname "$script_path")" && pwd -P)"
    #readonly script_dir="$(realpath $(dirname "$script_path"))"
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

ref.sh
Searches for and displays keywords across multiple lines in [references.txt] file in $notes_folder using grep and less.
Note: First argument may be available note file (prioritized) OR first keyword

Usage:
    ref [NOTE_FILE] [KEYWORDS]
    Note: NOTE_FILE should be specified without .txt extension
     -h|--help                  Displays this help
     -l|--list                  Displays searchable files in notes folder
     -k|--keywords              Explicitly define keywords (unavailable)
     -a|--all                   Search across all files in notes folder
     -g|--get                   Get filenames and line-numbers for lines matching keywords across all files
     --open                     Open file with default system editor
     --config                   Open configuration file

Example usage:
# Open references.txt:
ref 

# Multi-line search references.txt for keywords "bash" "loop"
ref bash loop

# Multi-line search file newfile.txt for keyword "python"
ref newfile python

# List available files in notes folder:
ref --list

# Multi-line search all files in note folder for "python"
ref --all python

EOF
}



# Run script
if ! (return 0 2> /dev/null); then
    main "$@"
fi
