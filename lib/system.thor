#!/user/bin/ruby

module Dotfiles
  class System < Base

    namespace :system

    no_tasks do
      def module_path
        "#{root}/system"
      end
    end

    desc 'add [URL]', 'Installs a system wide script/tool'
    method_options :force => :boolean
    def add(url)
      install_submodule url, module_path
    end

    desc 'rm [URL]', 'Uninstalls a system wide script/tool'
    method_options :force => :boolean
    def rm(url)
      say "Removing system script #{url}", :red
      uninstall_submodule url, module_path
    end

    desc 'install [FILE]', 'Installs all system files, saves your old files and symlinks new ones.'
    method_options :force => :boolean
    def install(component = nil)
      invoke "dotfiles:install", [], :linkable_path => File.join('**','system',"*#{component}.{link}")
    end

    desc 'uninstall [FILE]', 'Uninstalls all system files, reverts back all backups.'
    method_options :foce => :boolean
    def uninstall(component = nil)
      invoke "dotfiles:uninstall", [], :linkable_path => File.join('**','system',"*#{component}.{link}")
    end

  end # System
end # Dotfiles
