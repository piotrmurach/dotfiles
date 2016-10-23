#!/user/bin/ruby

module Dotfiles
  class Vim < Base
    namespace :vim

    no_tasks do
      def module_path
        "#{root}/vim/vim.link/bundle"
      end

      def plugins_path
        "#{root}/vim/plugins"
      end

      def plugins
        File.readlines(plugins_path)
      end

      def save_plugins(*plugin_names)
        File.open(plugins_path, 'wb') do |file|
          plugin_names.each { |plugin| file.puts(plugin) }
        end
      end

      def plugin_installed?(url)
        plugins.any? { |plugin| /#{url}/.match(plugin) }
      end

      def update_docs
        run "vim -e -c 'Helptags | quit'"
      end
    end

    desc 'update', 'Updates vim plugins'
    def update
      update_submodules
    end

    desc 'add [URL]', 'Adds a vim plugin'
    def add(url)
      if url.nil? || url.empty?
        say 'Provide repo uri.', :red
        return
      end
      if plugin_installed?(url)
        say 'Plugin already installed, check with dotfiles:vim:list', :red
        return
      end
      install_submodule url, module_path
      save_plugins(plugins << url)
      update_docs
    end

    desc 'rm [URL]', 'Removes vim plugin.'
    method_options force: :boolean, aliases: "-f"
    def rm(url)
      unless plugin_installed?(url)
        say "Plugin #{url} does not exists.", :red
        return
      end
      say "Removing vim plugin #{url}", :red
      uninstall_submodule url, module_path
      save_plugins plugins.reject { |plug| plug.strip == url }
    end

    desc 'pathogen', 'Installs pathogen if not already present'
    method_options force: :boolean
    def pathogen
      say 'Installing pathogen...', :green
      if File.exist?("#{user_home}/.vim/autoload/pathogen.vim") && !options[:force]
        return unless yes? 'Pathogen already installed, do you want to overwrite'
      end
      url = "https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim"
      run "curl -so #{root}/vim/vim.link/autoload/pathogen.vim #{url}"
    end

    desc 'install [FILE]', 'Install all vim files, saves your old vim config and symlinks new one'
    method_options force: :boolean
    def install(component = nil)
      paths = File.join('**', 'vim', "*#{component}.{link}")
      invoke('dotfiles:install', [], linkable_path: paths)
    end

    desc 'uninstall [FILE]', 'Uninstall all vim files, reverts back all backups.'
    method_options foce: :boolean
    def uninstall(component = nil)
      paths = File.join('**', 'vim', "*#{component}.{link}")
      invoke('dotfiles:uninstall', [], linkable_path: paths)
    end

    desc 'list', 'List currently installed extensions.'
    def list
      say(plugins.join, :green)
    end
  end # Vim
end # Dotfiles
