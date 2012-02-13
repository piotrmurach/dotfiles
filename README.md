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
thor dotfiles:base:update     # Pulls recent changes and updates modules
```

### Ruby
```
thor dotfiles:ruby:install [FILE]    # Installs specific ruby and irb extensions
thor dotfiles:ruby:uninstall [FILE]  # Uninstalls specific ruby and irb extensions
```

### Vim

Related vim tasks are scoped by vim namespace.

```
thor dotfiles:vim:install [FILE]   # Installs all vim goodness or specific component
thor dotfiles:vim:add 'git-repo'   # Install vim component
thor dotfiles:vim:rm  'git-repo'   # Uninstall vim component
thor dotfiles:vim:list             # List currently installed components
thor dotfiles:vim:update           # Updates all the components to the lastest
```

### Git

```
thor dotfiles:git:install [FILE]   # Installs all or specific git file
thor dotfiles:git:uninstall [FILE] # Uninstalls all or specific git file
thor dotfiles:git:add [URL]        # Adds new git component
thor dotfiles:git:rm [URL]         # Removes git component
```

### RVM

```
thor dotfiles:rvm:install  # Install rvm from source
thor dotfiles:rvm:update   # Update your version of rvm

```

## Environment
