#!/user/bin/ruby

module Dotfiles

  class Vim < Base

    no_tasks do
      LINES_TO_REMOVE = 3

      def extract_plugin_name url
        url.split('/').last.gsub('.git', '')
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
      say "Vim plugins updated", :green
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

    desc 'install [FILE]', 'Installs all vim files, saves your old vim config and symlinks new one'
    method_options :force => :boolean
    def install(component = nil)
      invoke "dotfiles:base:install", [], :linkable_path => File.join('**','vim',"*#{component}.{link}")
    end

    desc 'uninstall [FILE]', 'Uninstalls all vim files, reverts back all backups.'
    method_options :foce => :boolean
    def uninstall(component = nil)
      invoke "dotfiles:base:uninstall", [], :linkable_path => File.join('**','vim',"*#{component}.{link}")
    end

    desc 'list', 'List currently installed extensions.'
    def list
      plugins.each do |plugin|
        say plugin, :yellow
      end
    end

  end # Vim

end # Dotfiles
