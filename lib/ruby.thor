#!/user/bin/ruby

module Dotfiles

  class Ruby < Base
    include Thor::Actions

    desc 'install', 'Installs all ruby & irb files, saves your old files and symlinks new ones.'
    method_options :force => :boolean
    def install
      invoke "dotfiles:base:install", [], :linkable_path => File.join('**','ruby','*.{link}')
    end

    desc 'uninstall', 'Uninstalls all ruby files, reverts back all backups.'
    method_options :foce => :boolean
    def uninstall
      invoke "dotfiles:base:uninstall", [], :linkable_path => File.join('**','ruby','*.{link}')
    end

  end # Ruby

end # Dotfiles
