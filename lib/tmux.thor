#!/user/bin/ruby

module Dotfiles
  class Tmux < Base

    namespace :tmux

    desc 'setup', 'Installs Tmux'
    method_option :force, :type => :boolean, :aliases => "-f", :default => false
    def setup
      if check_presence('tmux') && !options[:force]
        say "tmux is already installed, skipping. Run task with -f to force", :red
      else
        say "Installing tmux for #{user}", :green
        run "brew install tmux"
      end
    end

    desc 'install', 'Installs all tmux files, saves your old files and symlinks new ones.'
    method_options :force => :boolean
    def install
      invoke "dotfiles:install", [], :linkable_path => File.join('**','tmux','*.{link}')
    end

    desc 'uninstall', 'Uninstall all tmux files, reverts back all backups.'
    method_options :foce => :boolean
    def uninstall
      invoke "dotfiles:uninstall", [], :linkable_path => File.join('**','tmux','*.{link}')
    end

  end # Tmux
end # Dotfiles
