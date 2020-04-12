# My dotfiles

A minimal set of config files to set up a system environment for maximum productivity.

I develop in Linux and OSX systems so I make sure that everything works for these systems.

The tools that I cannot develop without are:
* `bash`
* `git`
* `vim`
* `Ruby`

## Installation

In order to setup this dotfiles you will need `git` and `bundler`

Clone the repository

```bash
git clone git:://github.com/piotrmurach/dotfiles ~/.dotfiles
```

and then install dependencies

```bash
bundle install
```

## Usage

To see all available installation tasks do:

```bash
thor list
thor list [NAME]
```

To install all dotfiles do:

```bash
thor dotfiles:install
```

Or to install individual tools do:

```bash
thor vim:install
```

To sync dotfiles with github HEAD and update submodules do

```bash
thor dotfiles:update
```

## Copyright

Copyright (c) 2012 Piotr Murach. See LICENSE for further details.
