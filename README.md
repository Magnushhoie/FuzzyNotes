# bash_notes

Personal bash note-taking system with easy search and editing in place, directly from the terminal using vim.
Uses a combination of grep and vim to multi-line search keywords in references.txt or any file in ~/_bash_notes folder.
Used daily since 2019.

### Example of use:

https://terminalizer.com/view/ef4b2b193819

Installation:
```bash
bash setup.sh
```

#### 1. ref.sh:
Multi-line search for keywords in references.txt or other files in note folder

Usage:
- ref keywords: Search for keywords in references.txt
- ref filename keywords: Search for keywords in filename.txt

#### 2. refe.sh:
Opens/edits references.txt or other files in note folder at matching keywords

Usage:
- refe keywords: Search references.txt and open at line in Vim.
- refe --new filename.txt: Create new note file
- refe filename keywords: Search filename.txt for keywords

#### 3. setup.sh:
- Sets up bash_notes directory and adds scripts as aliases to .bash_profile
