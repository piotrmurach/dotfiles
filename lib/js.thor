#!/user/bin/ruby

module Dotfiles
  class JS < Base

    namespace :js

    no_tasks do
    end

    desc 'npm', 'Install NPM, the node package manager'
    def npm
      run "curl http://npmjs.org/install.sh | sh"
    end

    desc 'install [FILE]', 'Install all javascript files, saves your old files and symlinks new ones.'
    method_options :force => :boolean
    def install(component = nil)
      invoke "dotfiles:install", [], :linkable_path => File.join('**','js',"*#{component}.{link}")
    end

    desc 'uninstall [FILE]', 'Uninstall all git files, reverts back all backups.'
    method_options :foce => :boolean
    def uninstall(component = nil)
      invoke "dotfiles:uninstall", [], :linkable_path => File.join('**','js',"*#{component}.{link}")
    end

  end # JS
end # Dotfiles
