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

Sets up ~/_bash_notes directory and adds ref and refe as aliases to ~/.bash_profile. Edit [config.txt](config.txt) to change default notes directory and editor.

```bash
git clone https://github.com/Magnushhoie/bash_notes/
cd bash_notes
bash setup.sh
```

## Usage

Multi-line searches and edits personal note files using grep, less and Vim.\
Daily driver for managing code snippets since 2019.
See [references.txt](references.txt) for example.

```python
# ref.sh: Multi-line search for keywords in references.txt or other .txt files in note folder, opens in less
ref
ref <keywords>
ref notefile2 <keywords> # Search notefile2.txt
ref --all <keywords> # Search all .txt files in note folder
ref --list # List available note files in note folder

# refe.sh: Edit/open references.txt or other .txt file in note folder, with Vim or alternative editor
refe
refe <keywords>
refe notefile2 <keywords> # Search notefile2.txt
refe --open # Open using system default text editor (e.g. Atom, Sublime, TextEdit etc)
refe --new notefile2.txt # Create notefile2.txt in note folder
```

## Testing

```bash
bash test/test.sh
```

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
