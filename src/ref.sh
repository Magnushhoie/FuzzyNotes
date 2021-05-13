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
    readonly script_path="${BASH_SOURCE[0]}"
    readonly script_dir="$(realpath $(dirname "$script_path"))"
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
     -a|--all                   Search across all files notes folder (requires fzf) (unavailable)
     --open                     Open notefile reference file with default system editor instead of [vim]
     --config                   Open configuration file

Example usage:
ref 
ref <keywords>
ref newfile <keywords>

EOF
}

# DESC: Search script
function ref()
{
    filename=$primary_note_file

     # Check for alternative filename as first argument
     # If so, shift arguments so second+ becomes keyword
     alternative_filename=$(get_notefile $1)

     if [ $filename != "$alternative_filename" ];
         then filename=$alternative_filename
         shift
     fi

     echo $filename
     search_file $filename ${@:-""}
}

# Run script
if ! (return 0 2> /dev/null); then
    main "$@"
fi
