module Dotfiles

  def self.source_root
    File.dirname(__FILE__)
  end

  class Base < Thor
    include Thor::Actions

    desc 'install', 'install all dotfiles'
    def install
    end

    desc 'brew', 'Prints out a command to install homebrew package manager'
    def brew
    end

    desc 'rvm', 'Prints out a command to install RVM'
    def rvm
      say "bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)", :green
    end

    desc 'gcc', 'Prints out a command to install GCC'
    def gcc
    end
  end

  class Vim < Thor
    include Thor::Actions

    desc 'update', 'update vim'
    def update
      say "", :green
    end

    desc 'install_plugins', 'install all listed plugins'
    def install_plugins
    end
  end

end # Dotfiles
