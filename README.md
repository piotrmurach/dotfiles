# My dotfiles

A minimal set of config files to set up a system environment for maximum productivity.

I develop in Linux and OSX systems so I make sure that everything works for these systems.

The tools that I cannot develop without are:
* bash
* git 
* vim

## Installation

In order to setup this dotfiles you will need `git` and `bundler`

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
