# Piotr Murach Dot Files

A small set of config files to set up a system environment for maximum productivity.
My weapons of choice are OS X, homebrew, git, Ruby, vim and some more.

## Installation

```
git clone git:://github.com/peter-murach/dotfiles ~/.dotfiles
bundle install
thor dotfiles:install
```

## Usage

```
thor list                     # Lists all available tasks
thor dotfiles:base:install    # This will setup all files
```

### Ruby
```
thor dotfiles:ruby:install   # Installs specific ruby and irb extensions
thor dotfiles:ruby:install   # Uninstalls specific ruby and irb extensions
```

### Vim

Related vim tasks are scoped by vim namespace.

```
thor dotfiles:vim:install          # Installs all vim goodness
thor dotfiles:vim:add 'git-repo'   # Install vim component
thor dotfiles:vim:rm  'git-repo'   # Uninstall vim component
thor dotfiles:vim:list             # List currently installed components
thor dotfiles:vim:update           # Updates all the components to the lastest
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
