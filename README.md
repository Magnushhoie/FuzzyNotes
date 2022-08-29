<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Magnushhoie/FuzzyNotes">
  </a>

  <h1 align="center">FuzzyNotes</h3>

  <p align="center">
    Ultra-fast, <a href="">terminal based</a> note searching and editing app powered by <a href="https://github.com/junegunn/fzf">FZF</a> and <a href="https://danielmiessler.com/study/vim/">vim.</a> Click to watch tutorial:

  </p>
</p>

<p align="center">
<img src="img/image.jpg" alt="Logo" width="700">
</p>


### What is FuzzyNotes?

FuzzyNotes interactively searches and returns text search results from a nested folder of text files. Files are previewed or opened at exact match for copying or editing.
FuzzyNotes solves the problem of being unable to access text you forgot where you wrote. With FuzzyNotes, any written text will always be found, assuming its there.

## Usage
- fz: Interactively and recursively searches across all text files in ~/_FuzzyNotes/ directory. Opens file with less for easy copy-paste or scrolling
- fze: Lists all files with search match and previews matched text. Opens file in editor.

See [notes.txt](_FuzzyNotes/notes.txt) for example note file.

Typical use-cases are for project notes or log-books, code-snippets, or on top of knowledge management software like Obsidian or Roam. FuzzyNotes works with any nested collection of text files.


### Features:
- Interactive search with FZF, partial search matches
- Preview matches in side-bar
- Code highlighting
- fze always opens file at last edited location
- Assumes first keyword is either a file, or keywords (e.g. fz python hello world will either search python.txt or across all files)

## Installation

Sets up notes directory and adds aliases to ~/.bash_profile or ~/.zshrc.

```bash
# Requirements
brew install fzf
brew install bat

# Install
git clone https://github.com/Magnushhoie/FuzzyNotes/
cd FuzzyNotes
bash setup.sh
```


## Documentation

Use "**fz --help**" for all arguments.

#### fz - "Fuzzy" search and view

```bash
usage: fz [file] keywords
  keywords: Search terms, space-separated
  file: Optional, filename (without extension) in note folder

Example usage:
# Interactively search / preview / open files for selected lines starting with __ or #:
fz

# Search across all files for "list"
fz list
  
# Search across all lines (not just starting with __ or #)
fz -f

# Search python.py in note folder for "list" "comprehension"
fz python list comprehension
```

#### fze - "Fuzzy" edit

```bash
usage: fze [file] keywords
  keywords: Search terms, space-separated
  file: Optional, filename (without extension) in note folder

Example usage:
# Interactively select file in _FuzzyNotes
fze

# Open last modified file at last edited location by pressing Enter twice
fze <enter> <enter>

# Search file python.py (no extension) for keywords "for" and "loop". Opens match in vim.
fze python for loop
  
# Open _FuzzyNotes folder
fze --open
  
# Open file in system editor
fze --open notes.txt

# Add new file, named new_note.txt
fze -n new_note.txt
```

## Testing

```bash
bash test/test.sh
```

## Compatibility
Compatible with zsh. Tested on MacOS Mojave/Big Sur and Ubuntu 21.04.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Magnushhoie/FuzzyNotes.svg?style=for-the-badge
[contributors-url]: https://github.com/Magnushhoie/FuzzyNotes/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Magnushhoie/FuzzyNotes.svg?style=for-the-badge
[forks-url]: https://github.com/Magnushhoie/FuzzyNotes/network/members
[stars-shield]: https://img.shields.io/github/stars/Magnushhoie/FuzzyNotes.svg?style=for-the-badge
[stars-url]: https://github.com/Magnushhoie/FuzzyNotes/stargazers
[issues-shield]: https://img.shields.io/github/issues/Magnushhoie/FuzzyNotes.svg?style=for-the-badge
[issues-url]: https://github.com/Magnushhoie/FuzzyNotes/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/Magnushhoie/FuzzyNotes/blob/master/LICENSE.txt
