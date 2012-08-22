# Piotr Murach Dot Files

A small set of config files to set up a system environment for maximum productivity. My weapons of choice are OS X, homebrew, git, Ruby, vim and some more.

## Installation

```
git clone git:://github.com/peter-murach/dotfiles ~/.dotfiles
bundle install
thor dotfiles:install
```

## Usage

### All dotfiles

To setup all dotfiles do `thor dotfiles:install` or pick and choose.
```
thor list                # Lists all available tasks
thor dotfiles:install    # This will setup all dot files in home directory
thor dotfiles:update     # Pulls recent changes and updates modules
thor dotfiles:toolbox    # Installs essential tools using homebrew
thor dotfiles:update     # Syncs dotfiles with the the github repository
```

### Git

```
thor git:install [FILE]   # Installs all or specific git file
thor git:uninstall [FILE] # Uninstalls all or specific git file
thor git:add [URL]        # Adds new git component
thor git:rm [URL]         # Removes git component
```

### Vim

Related vim tasks are scoped by vim namespace.

```
thor vim:install [FILE]   # Installs all vim goodness or specific component
thor vim:add 'git-repo'   # Install vim component
thor vim:rm  'git-repo'   # Uninstall vim component
thor vim:list             # List currently installed components
thor vim:update           # Updates all the components to the lastest
```

### Ruby
```
thor ruby:install [FILE]    # Installs specific ruby and irb extensions
thor ruby:uninstall [FILE]  # Uninstalls specific ruby and irb extensions
```

### RVM
```
thor rvm:install  # Install rvm from source
thor rvm:update   # Update your version of rvm
```

## System

Helps to manage tools that improve productivity inside unix/bsd system.

```
thor system:add [URL]         # Installs a system wide script/tool
thor system:install [FILE]    # Installs all system files
thor system:rm [URL]          # Uninstalls a system wide script/tool
thor system:uninstall [FILE]  # Uninstalls all system files
```

## Copyright

Copyright (c) 2012 Piotr Murach. See LICENSE for further details.
