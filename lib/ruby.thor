#!/user/bin/ruby

module Dotfiles
  class Ruby < Base
    include Thor::Actions

    namespace :ruby

    desc 'install [FILE]', 'Installs all ruby & irb files, saves your old files and symlinks new ones.'
    method_options :force => :boolean
    def install(component = nil)
      invoke "dotfiles:base:install", [], :linkable_path => File.join('**','ruby',"*#{component}.{link}")
    end

    desc 'uninstall [FILE]', 'Uninstalls all ruby files, reverts back all backups.'
    method_options :foce => :boolean
    def uninstall(component = nil)
      invoke "dotfiles:base:uninstall", [], :linkable_path => File.join('**','ruby',"*#{component}.{link}")
    end

  end # Ruby
end # Dotfiles
