# Piotr Murach Dot Files

A small set of config files to set up a system environment for maximum productivity. My weapons of choice are OS X, homebrew, git, Ruby, vim and some more.

## Installation

Clone the repository

```bash
git clone git:://github.com/peter-murach/dotfiles ~/.dotfiles
```

and then update dependencies

```bash
bundle install
```

## Usage

To see all available installation tasks do:

```bash
thor list
```

To install all dotfiles do:

```bash
thor dotfiles:install
```

To sync dotfiles with github HEAD and update submodules do

```bash
thor dotfiles:update
```

To list all submodules do:

```bash
thor dotfiles:modules
```

## Copyright

Copyright (c) 2012-2016 Piotr Murach. See LICENSE for further details.
