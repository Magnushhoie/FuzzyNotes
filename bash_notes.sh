#!/bin/bash
ref_folder=$HOME/_References
papers_folder=$HOME/Desktop/Papers

notefile="$ref_folder/references.txt"
PDF_PAPERS_FOLDER="/Users/admin/Library/Application Support/Mendeley Desktop/Downloaded"
PDF_PAPERS_DOWNLOAD_FOLDER="$ref_folder/pdfs/paper_download"
bash_notes="$(realpath ${BASH_SOURCE[0]})"

ref_help() # Show all functions in bash_notes.sh
{
echo -e 'Your main note file is references.txt in folder ~/_References/.\nTo search or edit it, use "ref search terms here", or "refv". Both accept additional search keywords.'
echo -e "Tip: Use refv your_new_file.txt to create a new notefile. Search or edit it with ref / refv your_new_file\n"
echo $(realpath $bash_notes)
grep --color=always "^function " $bash_notes
}

function ref_list() # List note files in Reference folder
{
refv list
}

ref_get_notefile() # Helper function for ref functions
{
# Searches note folder for notefile. Default is references.txt
# Alternative name given if first argument matches that basename excluding file extension
# New filename given if first argument ends in .txt
# List of available files given if first argument is "list"

    # Modify these three to change default file or folder
    firstword=${1:-"references"}

    # Search for .txt files in reference folder
    files=($ref_folder/*.txt)

    # Look for alternative notefiles in folder if matches first argument
    for file in ${files[*]}; do
        file_shorthand=$(basename "${file%%.*}")
        if [ "$file_shorthand" = $firstword ];
            then notefile=$file
        fi;
        done

    # Override with NEW filename if first argument ends with *.txt !
    # First check lengths greater or equal than 4 to prevent error
    if [ ${#firstword} -ge 4 ];
        then if [ ${firstword: -4} = ".txt" ];
            then notefile=$ref_folder/$firstword
        fi
    fi

    # Print list of available files
    if [ $firstword = "-h" -o $firstword = "--help" -o $firstword = "list" ];
        then for each in ${files[*]};
        do echo $each; done
    fi

    # Return notefile
    echo $notefile
}

search_file() {
filename=$1
  grep --color=always -B 8 -A 20 $2 "$filename" |
  grep --color=always -B 4 -A 10 "$2" |
  grep --color=always -B 4 -A 10 "$3" |
  grep --color=always -B 4 -A 10 "$4" |
  grep --color=always -B 4 -A 10 "$5" |
  grep --color=always -B 4 -A 10 "$6" |
  less -R
}


search_folder() {
folder=$1
script_files=($(find $ref_folder -type f -not -path '*/\.*'))

{ for file in ${script_files[@]}; do
    grep --color=always -i -B 8 -A 20 $2 $file /dev/null;  done } |
grep --color=always -i -B 4 -A 10 "$2" |
grep --color=always -i -B 4 -A 10 "$3" |
grep --color=always -i -B 4 -A 10 "$4" |
grep --color=always -i -B 4 -A 10 "$5" |
grep --color=always -B 4 -A 10 "$6" |
less -R
}

search_folder_top_only() {
folder=$1
script_files=($(find $ref_folder -maxdepth 1 -type f -not -path '*/\.*'))

{ for file in ${script_files[@]}; do
    grep --color=always -i -B 8 -A 20 $2 $file /dev/null;  done } |
grep --color=always -i -B 4 -A 10 "$2" |
grep --color=always -i -B 4 -A 10 "$3" |
grep --color=always -i -B 4 -A 10 "$4" |
grep --color=always -i -B 4 -A 10 "$5" |
grep --color=always -B 4 -A 10 "$6" |
less -R
}

function ref() # Search references.txt. Accepts search terms and/or files in search folder. E.g. ref datascience.txt Randomforest
{
    filename=$(ref_get_notefile)

     # Check for alternative filename as first argument
     # If so, shift arguments so second+ becomes keyword
     alternative_filename=$(ref_get_notefile $1)
     if [ $filename != $alternative_filename ];
         then filename=$alternative_filename
         shift
     fi

     echo $filename
     search_file $filename ${@:-"\s"}
}

function refv() # Search and edit references.txt in vim. Can create new files, e.g. refv datascience.txt
{
# Opens up vim at first mention of keyword(s)
# Notefile is references.txt, unless another file found from first argument
     filename=$(ref_get_notefile)

    # Print list of available files
    if [ $1 = "-h" -o $1 = "-help" -o $1 = "list" ];
        then echo -e "\nAvailable files:"
             for each in $(ref_get_notefile $1);
             do ls -ltrh $each; done

             echo -e "\nMain reference file: \t" $filename
             echo -e "Search or edit: \t refv keyword1 keyword2 ..."
             echo -e "Alternative file: \t refv different_name"
             echo -e "Add new file:   \t refv new_file.txt"
             return [n]
    fi

     # Check for alternative filename as first argument
     # If so, shift arguments so second+ becomes keyword
     alternative_filename=$(ref_get_notefile $1)
     if [ $filename != $alternative_filename ];
         then filename=$alternative_filename
         shift
     fi

    # Run vim on keywords
    if [ -z $1 ];
    then vim "$filename"
    else vim +":set hlsearch" +/$1.*$2.*$3.*$4.*$5 $filename
    fi
}

function ref_notes() # Search all files in top level directory _References
{
search_folder_top_only $ref_folder ${@:-"\s"}
}

function ref_all() # Search all files in _References, recursively
{
search_folder $ref_folder ${@:-"\s"}
}
