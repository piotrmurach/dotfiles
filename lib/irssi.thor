#!/user/bin/ruby

module Dotfiles
  class Irssi < Base
    namespace :irssi

    desc 'install', 'Installs all git files, saves your old files and symlinks new ones.'
    method_options :force => :boolean
    def install
      invoke "dotfiles:base:install", [], :linkable_path => File.join('**','irssi','*.{link}')
    end

    desc 'uninstall', 'Uninstalls all git files, reverts back all backups.'
    method_options :foce => :boolean
    def uninstall
      invoke "dotfiles:base:uninstall", [], :linkable_path => File.join('**','irssi','*.{link}')
    end
  end # Irssi
end # Dotfiles
