# Piotr Murach Dot Files

A small set of config files to set up a system environment for maximum productivity.

## Installation

```
git clone git:://github.com/peter-murach/dotfiles ~/dotfiles
bundle install
thor dotfiles:install
```

## Usage

See all available tasks:
```
thor list
```

### Ruby


### Vim

Related vim tasks are scoped by vim namespace. Installing vim component:

```
thor dotfiles:vim:add 'git-repo'
```

### RVM

Install rvm from source

```
thor dotfiles:rvm:install
```

Update your version of rvm

```
thor dotfiles:rvm:update
```

## Environment
