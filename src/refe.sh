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
     -n|--new                   Explicitly create new file (.txt extension required)
     -k|--keywords              Explicitly define keywords (unavailable)
     --open                     Open notefile reference file with default system editor instead of $EDITOR
     --config                   Open configuration file

Example usage:
refe 
refe keyword1 keyword2
refe --new newfile.txt
refe newfile keyword1

EOF
}

# DESC: Edit script
function refe() # Search and edit references.txt in vim. Can create new files, e.g. refe --new datascience.txt
{
# Opens up EDTIOR (vim) at first mention of keyword(s)
# Notefile is references.txt, unless another file found from first argument
     filename=$(get_notefile)

     # Check for alternative filename as first argument
     # If so, shift arguments so second+ becomes keyword
     alternative_filename=$(get_notefile $1)
     if [ $filename != $alternative_filename ];
         then filename=$alternative_filename
         shift
     fi

     echo $filename

    if [ $EDITOR == "vim" ];
        then 
        # If keywords are not empty, try to search
        if ! [ -z $1 ];
            then vim +":set hlsearch" +/$1.*$2.*$3.*$4.*$5.*$6 $filename
            # Else open vim without search
            else vim "$filename"
        fi
    else
        # Open with alternative editor if not vim
        $EDITOR "$filename"
    fi
}

# Run script
if ! (return 0 2> /dev/null); then
    main "$@"
fi