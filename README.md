# vim-lotus

This plugin helps you navigate and develop projects using the [Lotus web
framework][lotus]. A Lotus project is detected by searching a .lotusrc file up
the directory hierarchy. When you edit a file in a Lotus project, this plugin
will be activated. This sets various options and defines some commands. It also
integrates with other Vim plugins.

## Features

* Integrates with [vim-projectionist][] for navigating project files according
  to Lotus conventions.
* Comes with extra mappings for [vim-surround][].
* Comes with extra snippets for [UltiSnips][].
* Provides `:Lotus` command that delegates to the Lotus CLI.
* Provides project-specific Vim navigation settings for `path` and
  `suffixesadd`.

See the documentation (`:help lotus`) for more information.

## Installation

Use your favourite Vim plugin manager to install this plugin. I use
[pathogen][]. Otherwise, download this plugin and put the files in its
subdirectories to the corresponding subdirectories in your `~/.vim` directory.

## About

To find our more about the Lotus framework, see: https://github.com/lotus/lotus

To get the latest updates or report bugs, see this plugin's Github repository: https://github.com/avdgaag/vim-lotus

## Credits

Author: Arjan van der Gaag
URL: http://arjanvandergaag.nl

## License

See LICENSE.

[vim-projectionist]: https://github.com/tpope/vim-projectionist
[vim-surround]:      https://github.com/tpope/vim-surround
[UltiSnips]:         https://github.com/SirVer/UltiSnips
[vim-pathogen]:      https://github.com/tpope/vim-pathogen
[lotus]:             https://github.com/lotus/lotus
