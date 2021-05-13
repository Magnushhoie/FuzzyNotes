# bash_notes

Personal bash note-taking system with easy search and editing in place, directly from the terminal using vim.
Uses a combination of grep and vim to multi-line search keywords in references.txt or any file in ~/_bash_notes folder.
Daily driver for managing code snippets since 2019.

# Installation:
```bash
git clone https://github.com/Magnushhoie/bash_notes/
cd bash_notes
bash setup.sh
```

# Testing:
```bash
bash test/test.sh
```

# Usage:

#### 1. ref.sh:
Multi-line search for keywords in references.txt or other .txt files in note folder

Usage:
- ref: Opens references.txt in less
- ref keywords: Search for keywords in references.txt
- ref filename keywords: Search for keywords in filename.txt

#### 2. refe.sh:
Opens/edits references.txt or other .txt files in note folder at matching keywords

Usage:
- refe: Opens references.txt in Vim
- refe keywords: Search references.txt and open at line in Vim.
- refe --new filename.txt: Create new note file
- refe filename keywords: Search filename.txt for keywords

#### 3. setup.sh:
- Sets up bash_notes directory and adds scripts as aliases to .bash_profile
