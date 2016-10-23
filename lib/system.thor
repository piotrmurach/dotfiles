#!/user/bin/ruby

module Dotfiles
  class System < Base
    namespace :system

    no_tasks do
      def module_path
        "#{root}/system"
      end
    end

    desc 'install [FILE]', 'Installs all system files, saves your old files and symlinks new ones.'
    method_options force: :boolean
    def install(component = nil)
      paths = File.join('**', 'system', "*#{component}.{link}")
      invoke('dotfiles:install', [], linkable_path: paths)
    end

    desc 'uninstall [FILE]', 'Uninstalls all system files, reverts back all backups.'
    method_options foce: :boolean
    def uninstall(component = nil)
      paths = File.join('**', 'system', "*#{component}.{link}")
      invoke('dotfiles:uninstall', [], linkable_path: paths)
    end
  end # System
end # Dotfiles
