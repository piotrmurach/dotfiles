#!/user/bin/ruby

module Dotfiles
  class Git < Base

    namespace :git

    no_tasks do
      def module_path
        "#{root}/git"
      end
    end

    desc 'add [URL]', 'Installs a merge/diff tool, currently supports `Meld`'
    method_options :force => :boolean
    def add(url)
      install_submodule url, module_path
      name = extract_module_name url

      if url =~ /meld/
        say 'Installing MELD on your system'
        run " cd #{root}/git/#{name} && sudo make prefix=/usr/local install "
      end
    end

    desc 'rm [URL]', 'Uninstalls a merge/diff tool, currently supports `Meld`'
    method_options :force => :boolean
    def rm(url)
      say "Removing git tool #{url}", :red
      uninstall_submodule url, module_path
    end

    desc 'install [FILE]', 'Installs all git files, saves your old files and symlinks new ones.'
    method_options :force => :boolean
    def install(component = nil)
      invoke "dotfiles:install", [], :linkable_path => File.join('**','git',"*#{component}.{link}")
    end

    desc 'uninstall [FILE]', 'Uninstalls all git files, reverts back all backups.'
    method_options :foce => :boolean
    def uninstall(component = nil)
      invoke "dotfiles:uninstall", [], :linkable_path => File.join('**','git',"*#{component}.{link}")
    end

  end # Git
end # Dotfiles
