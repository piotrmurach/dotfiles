module Dotfiles

  class Base < Thor
    include Thor::Actions

    no_tasks do
      def root
        File.dirname(__FILE__)
      end

      def user
        @user = %x["whoami"].chomp
      end
    end

    desc 'install', 'install all dotfiles'
    def install
    end

    desc 'brew', 'Prints out a command to install homebrew package manager'
    def brew
      say "Installing homebrew for #{user}", :green
    end

    desc 'rvm', 'Install RVM'
    def rvm
      say "Installing rvm for #{user}", :green
      run "bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)"
    end

    desc 'gcc', 'Prints out a command to install GCC'
    def gcc
    end

  end # Base

  class Rvm < Base

    desc 'update', ''
    def update
      run "rvm get head"
    end

  end

  class Vim < Base

    no_tasks do

      def install_plugin(url)
        name = url.split('/').last.gsub('.git', '')
        say "Installing #{name} from #{url} as submodule", :green
        run 'git submodule add #{url} #{root}/vim/bundle/#{name}'
        run 'git submodule init'
        run 'git submodule update'
      end

      def read_plugins
        File.read "#{root}/vim/plugins.txt"
      end

      def save_plugins(*plugins)
        File.open("#{root}/vim/plugins.txt", 'w+') do |file|
          file.write plugins.join('\n')
        end
      end

      def extract_plugin_name(name)
      end

      def update_docs
        run "vim -e -c 'Helptags | quit'"
      end
    end

    desc 'update', 'update vim'
    def update
      say "Updating vim for #{user}", :green
    end

    desc 'add', 'Adds a vim plugin'
    def add(url)
      error 'Provide repo uri.' if url.nil?
      install_plugin url
      save_plugins read_plugins << url
      update_docs
    end

    desc 'rm', 'Removes plugin'
    def rm(url)
      say "Removing vim plugin", :red
    end

    desc 'pathogen', 'Installs pathogen if not already present'
    def pathogen
      say 'Installing pathogen...', :green
      if File.exists?("#{root}/vim/autoload/pathogen.vim")
        return unless yes? 'Pathogen already installed, do you want to overwrite'
      end
      url = "https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim"
      run "curl -so #{root}/vim/autoload/pathogen.vim #{url}"
    end

    desc 'install', 'Installs all plugins, saves your old vim config and symlinks new one'
    def install
    end

    desc 'list', 'List currently installed extensions.'
    def list
    end

  end # Vim

end # Dotfiles
