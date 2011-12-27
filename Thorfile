#!/user/bin/ruby

require 'fileutils'

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

    desc 'install', 'Hook dotfiles into system-standard positions.'
    def install
    end

    desc'uninstall', 'Uninstall all dotfiles.'
    def uninstall
    end

    desc 'brew', 'Installs homebrew package manager'
    def brew
      say "Installing homebrew for #{user}", :green
      run " /usr/bin/ruby -e \"$(curl -fsSL https://raw.github.com/gist/323731)\""
    end

    desc 'gcc', 'Prints out a command to install GCC'
    def gcc
    end

  end # Base

  class Ruby < Base
    include Thor::Actions

    desc 'install', 'Install all ruby & irb files, save your old files and symlinks new ones'
    method_options :force => :boolean
    def install
      linkables = Dir.glob('ruby/**{.link}')
    end

  end # Ruby

  class Rvm < Base

    desc 'install', 'Installs RVM'
    def install
      say "Installing rvm for #{user}", :green
      run "bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)"
    end

    desc 'update', 'Updates RVM to newest version'
    def update
      run "rvm get head"
    end

  end # Rvm

  class Git < Base

  end # Git

  class Vim < Base

    no_tasks do
      LINES_TO_REMOVE = 3

      def extract_plugin_name url
        url.split('/').last.gsub('.git', '')
      end

      def extract_symlink_name path
        path.split('/').last.gsub('.link','')
      end

      def install_plugin url
        name = extract_plugin_name url
        say "Installing #{name} from #{url} as submodule", :green
        run "git submodule add #{url} vim/vim.link/bundle/#{name}"
        run 'git submodule init'
        run 'git submodule update'
      end

      def plugins
        File.readlines("#{root}/vim/plugins.list")
      end

      def save_plugins *plugin_names
        File.open("#{root}/vim/plugins.list", 'wb') do |file|
          plugin_names.each { |plugin| file.puts plugin }
        end
      end

      def plugin_installed? url
        plugins.include? url
      end

      def update_docs
        run "vim -e -c 'Helptags | quit'"
      end

      def delete_git_module name
        gitmodules = File.readlines("#{root}/.gitmodules")
        index = nil
        gitmodules.each_with_index do |line, indx|
          index = indx; break if line.index(name)
        end
        if index
          gitmodules.slice!(index, LINES_TO_REMOVE)
        end
        File.open("#{root}/.gitmodules", 'w+') do |file|
          gitmodules.each { |line| file.puts(line) }
        end
      end
    end

    desc 'update', 'Updates vim plugins'
    def update
      say "Updating vim plugins for #{user}", :green
      [
        'git submodule init',
        'git submodule update',
        'git submodule foreach git checkout master',
        'git submodule foreach git pull -q origin master'
      ].each do |cmd|
        run "#{cmd}"
      end
      say "Plugins updated", :green
    end

    desc 'add [URL]', 'Adds a vim plugin'
    def add(url)
      if url.nil? || url.empty?
        say 'Provide repo uri.', :red
        return
      end
      if plugin_installed? url
        say 'Plugin already installed, check with dotfiles:vim:list', :red
        return
      end
      install_plugin url
      save_plugins plugins << url
      update_docs
    end

    desc 'rm [URL]', 'Removes vim plugin.'
    method_options :force => :boolean, :aliases => "-f"
    def rm(url)
      unless plugin_installed?(url)
        say "Plugin #{url} does not exists.", :red
      end
      say "Removing vim plugin #{url}", :red

      delete_git_module extract_plugin_name(url)
      run "git rm --cached #{root}/vim/vim.link/bundle/#{extract_plugin_name(url)}"
      FileUtils.rm_rf "#{root}/vim/vim.link/bundle/#{extract_plugin_name(url)}"

      save_plugins plugins.reject { |plug| plug.strip == url }
    end

    desc 'pathogen', 'Installs pathogen if not already present'
    method_options :force => :boolean
    def pathogen
      say 'Installing pathogen...', :green
      if File.exists?("#{root}/vim/vim.link/autoload/pathogen.vim") && !options[:force]
        return unless yes? 'Pathogen already installed, do you want to overwrite'
      end
      url = "https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim"
      run "curl -so #{root}/vim/vim.link/autoload/pathogen.vim #{url}"
    end

    desc 'install', 'Installs all vim files, saves your old vim config and symlinks new one'
    method_options :force => :boolean
    def install

      skip_all = false
      overwirte_all = false
      backup_all = false

      # TODO could be a block in Base that accepts linkable dir
      linkables = Dir.glob('vim/**{.link}')

      linkable.each do |linkable|
        file = extract_symlink_name linkable
        target = "#{ENV['HOME']}/.#{file}"

        if File.exists?(target) || File.symlink?(target)
          unless skip_all || overwrite_all || backup_all
            case ask("File already exists: #{target}, what do you want to do? \n [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all", :green)
              when 'o' then overwrite = true
              when 'b' then backup = true
              when 'O' then overwrite_all = true
              when 'B' then backup_all = true
              when 'S' then skip_all = true
              when 's' then next
            end
          end
          FileUtils.rm_rf(target) if overwrite || overwrite_all
          FileUtils.mv target, "#{target}.backup" if backup || backup_all
        end
        link_file file, target, options[:force]
      end
    end

    desc 'list', 'List currently installed extensions.'
    def list
      say plugins, :yellow
    end

  end # Vim


end # Dotfiles
