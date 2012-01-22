#!/user/bin/ruby

module Dotfiles

  class Git < Base

    desc 'install [FILE]', 'Installs all git files, saves your old files and symlinks new ones.'
    method_options :force => :boolean
    def install(component = nil)
      invoke "dotfiles:base:install", [], :linkable_path => File.join('**','git',"*#{component}.{link}")
    end

    desc 'uninstall [FILE]', 'Uninstalls all git files, reverts back all backups.'
    method_options :foce => :boolean
    def uninstall(component = nil)
      invoke "dotfiles:base:uninstall", [], :linkable_path => File.join('**','git',"*#{component}.{link}")
    end

  end # Git

end # Dotfiles
