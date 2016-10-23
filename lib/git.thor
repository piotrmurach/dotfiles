#!/user/bin/ruby

module Dotfiles
  class Git < Base
    namespace :git

    no_tasks do
      def module_path
        "#{root}/git"
      end
    end

    desc 'install [FILE]', 'Installs all git files, saves your old files and symlinks new ones.'
    method_options force: :boolean
    def install(component = nil)
      paths = File.join('**', 'git', "*#{component}.{link}")
      invoke 'dotfiles:install', [], linkable_path: paths
    end

    desc 'uninstall [FILE]', 'Uninstalls all git files, reverts back all backups.'
    method_options foce: :boolean
    def uninstall(component = nil)
      paths = File.join('**', 'git', "*#{component}.{link}")
      invoke 'dotfiles:uninstall', [], linkable_path: paths
    end
  end # Git
end # Dotfiles
