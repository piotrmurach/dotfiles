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
thor list                # Lists all available tasks
thor dotfiles:install    # This will setup all dot files in home directory
thor dotfiles:update     # Pulls recent changes and updates modules
```

### Ruby
```
thor ruby:install [FILE]    # Installs specific ruby and irb extensions
thor ruby:uninstall [FILE]  # Uninstalls specific ruby and irb extensions
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

### Git

```
thor git:install [FILE]   # Installs all or specific git file
thor git:uninstall [FILE] # Uninstalls all or specific git file
thor git:add [URL]        # Adds new git component
thor git:rm [URL]         # Removes git component
```

### RVM

```
thor rvm:install  # Install rvm from source
thor rvm:update   # Update your version of rvm

```

## Environment
