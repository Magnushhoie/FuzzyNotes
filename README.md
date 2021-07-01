<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Magnushhoie/bash_notes">
    <img src="img/bash_notes.png" alt="Logo">
  </a>

  <h3 align="center">bash_notes</h3>

  <p align="center">
    Personal BASH note-taking and code-snippet system using Vim, grep and less. 
    <br />
  </p>
</p>

## Installation

Sets up notes directory and adds aliases to ~/.bash_profile.

```bash
git clone https://github.com/Magnushhoie/bash_notes/
cd bash_notes
bash setup.sh
```

## Usage
View keyword search results across note files with __ref__ and open files at matches with __refe__ from the terminal.
Program based on combination of grep, less and vim. Used daily for managing code snippets since 2019.
See [references.txt](references.txt) for example note file.

```text
# ref.sh: View matches for searched keywords in note files
# usage: ref.sh [notefile] keywords

# Example usage:
# View main note file:
ref 

# Search main note file for keywords "bash" "loop"
ref bash loop

# Search file newfile.txt in note folder for keywords "python"
ref newfile python

# Search across all files in note folder for keywords "python" "list"
ref -a python list
```

<br>

```text
# refe.sh: Open note file at searched line with Vim or alternative editor
# usage: [notefile] keywords

# Example usage:
# Open main note file in editor:
refe

# Open main note file at first line with "bash loop"
refe bash loop

# Create newfile.txt in notes folder
refe -n newfile.txt

# Open newfile.txt at first line with "python"
refe newfile python
```

## Testing

```bash
bash test/test.sh
```

## Compatibility
Tested on MacOS Mojave and Ubuntu 21.04. Compatible with zsh.

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/Magnushhoie/bash_notes.svg?style=for-the-badge
[contributors-url]: https://github.com/Magnushhoie/bash_notes/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/Magnushhoie/bash_notes.svg?style=for-the-badge
[forks-url]: https://github.com/Magnushhoie/bash_notes/network/members
[stars-shield]: https://img.shields.io/github/stars/Magnushhoie/bash_notes.svg?style=for-the-badge
[stars-url]: https://github.com/Magnushhoie/bash_notes/stargazers
[issues-shield]: https://img.shields.io/github/issues/Magnushhoie/bash_notes.svg?style=for-the-badge
[issues-url]: https://github.com/Magnushhoie/bash_notes/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/Magnushhoie/bash_notes/blob/master/LICENSE.txt
