#!/user/bin/ruby

module Dotfiles

  class Git < Base

    desc 'install', 'Installs all git files, saves your old files and symlinks new ones.'
    method_options :force => :boolean
    def install
      invoke "dotfiles:base:install", [], :linkable_path => File.join('**','git','*.{link}')
    end

    desc 'uninstall', 'Uninstalls all git files, reverts back all backups.'
    method_options :foce => :boolean
    def uninstall
      invoke "dotfiles:base:uninstall", [], :linkable_path => File.join('**','git','*.{link}')
    end

  end # Git

end # Dotfiles
