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
    readonly script_dir="$(cd "$(dirname "$script_path")" && pwd -P)"
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
usage: $script_name [notefile] keywords
  notefile: File basename in note folder if existing. Default is references.txt
  keywords: Search terms, space-separated

Optional arguments:
     -l|--list                  Displays searchable files in notes folder
     -n|--new                   Create new file in notes folder
     -h|--help                  Displays this help
     --open                     Open file with default system editor
     --config                   Open configuration file

Example usage:
Open main note file in editor:
refe

Open main note file at first line with "bash loop"
refe bash loop

Create newfile.txt in notes folder
refe -n newfile.txt

Open newfile.txt at first line with "python"
refe newfile python
EOF
}

# Run script
if ! (return 0 2> /dev/null); then
    main "$@"
fi
