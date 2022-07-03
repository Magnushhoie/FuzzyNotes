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
    Ultra-fast, <a href="">terminal based</a> note writing and search app powered by <a href="https://github.com/junegunn/fzf">FZF</a> and <a href="https://danielmiessler.com/study/vim/">vim.</a> Click to watch tutorial:

  </p>
</p>

<p align="center">
<a href="https://asciinema.org/a/458105">
<img src="img/image.jpg" alt="Logo" width="700">
</p>

FuzzyNotes solves the problem of losing notes, code or things you want to remember written across multiple files.
fz interactively fuzzy searches across all your note files - or a specific file - instantly retrieving information wherever its written.
fze returns you to exactly where you last added text or to any search match, interactively.
Ideal for code-snippets, things to remember or write notebooks. Works well with Obsidian or any collection of text-only files.


### Features:
- Interactively search / edit / view note files in ~/FuzzyNotes/ directory (powered by FZF)
- Instantly preview file contents and search match in side-bar
- Code highlighting
- Partial search matches
- Quickly return to last changed location in file
- First keywords can be filenames or keywords
- (not implemented) image and markdown support inside the terminal

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

## Usage
- fz: Interactively search across all note files (default in $HOME/_FuzzyNotes/ directory)
- fze: List available files and their content, open file in vim on default system editor

See [main.txt](_FuzzyNotes/main.txt) for example note file.

## Documentation

Use "**fz --help**" for all arguments.

#### fz - "Fuzzy look-up", search and view

```text
fz --help
usage: fz [file] keywords
  file: File basename in note folder if existing. Default is main.txt
  keywords: Search terms, space-separated

Optional arguments:
  -l|--list                  Display and open files in notes folder
  -h|--help                  Displays this help

Example usage:
Interactively search and view files for lines starting with __ or #:
fz

Search for keywords "for" "loop"
fz for loop

Search python.py in note folder for "list" "comprehension"
fz python list comprehension
```

#### fze - "Fuzzy edit", search and edit

```text
fze --help
usage: fze [file] keywords
  file: File basename in note folder if existing. Default is main.txt
  keywords: Search terms, space-separated

Optional arguments:
     -o|--open                  Open file with default system editor
     -n|--new                   Create [filename] in notes folder
     -l|--list                  Displays searchable files in notes folder
     -h|--help                  Displays this help

Example usage:
Preview files in notes folder, then open selected file in vim
fze

Open and edit python.py at first line with "for loop"
fze python for loop

Create newfile.txt in notes folder
fze -n newfile.txt
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
