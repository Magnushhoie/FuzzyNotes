#!/bin/bash
# bash_notes function for editing reference file
# https://github.com/Magnushhoie/bash_notes

# DESC: Main control flow
function main() {
    script_init "$@"
    parse_params "$@"
    refe "$@"
}

# DESC: Initialization parameters
function script_init() {
    readonly script_path="${BASH_SOURCE[0]}"
    readonly script_dir="$(realpath $(dirname "$script_path"))"
    readonly main_dir=$(dirname $script_dir)
    readonly script_params="$*"

    # Read in notes_folder and primary_note_file. By default ~/_bash_notes/ and ~/_bash_notes/references.txt
    source $main_dir/config.txt

    # Read in search scripts.
    source $script_dir/functions.sh
}

# DESC: Usage help
function script_usage() {
    cat << EOF

refe.sh
Opens/edits [references.txt] in $notes_folder at line matching keywords, using $EDITOR or editor set in config.txt file.

Usage:
    ref [NOTE_FILE] [KEYWORDS]
    Note: NOTE_FILE should be specified without .txt extension
     -h|--help                  Displays this help
     -l|--list                  Displays searchable files in notes folder
     -k|--keywords              Explicitly define keywords (unavailable)
     -n|--new                   Create new file in notes folder (.txt extension required)
     --open                     Open file with default system editor
     --config                   Open configuration file

Example usage:
refe 
refe <keywords>
refe --new newfile.txt
refe newfile <keywords>

EOF
}

# Run script
if ! (return 0 2> /dev/null); then
    main "$@"
fi
