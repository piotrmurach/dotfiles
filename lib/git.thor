#!/user/bin/ruby

module Dotfiles
  class Git < Base

    namespace :git

    no_tasks do
      LINES_TO_REMOVE = 4

      def extract_module_name url
        url.split('/').last.gsub('.git', '')
      end

      def install_submodule url
        name = extract_module_name url
        say "Installing #{name} from #{url} as git submodule", :green
        run "git submodule add #{url} git/#{name}"
        run 'git submodule init'
        run 'git submodule update'
        ignore_submodule name
      end

      def delete_git_module name
        gitmodules = File.readlines("#{root}/.gitmodules")
        index = nil
        gitmodules.each_with_index do |line, indx|
          index = indx; break if line.index(name)
        end
        if index
          gitmodules.slice!(index, LINES_TO_REMOVE)
        end
        File.open("#{root}/.gitmodules", 'w+') do |file|
          gitmodules.each { |line| file.puts(line) }
        end
      end
    end

    desc 'add [URL]', 'Installs a merge/diff tool, currently supports `Meld`'
    method_options :force => :boolean
    def add(url)
      install_submodule url

      name = extract_module_name url

      if url =~ /meld/
        say 'Installing MELD on your system'
        run " cd #{root}/git/#{name} && sudo make prefix=/usr/local install "
      end
    end

    desc 'rm [URL]', 'Uninstalls a merge/diff tool, currently supports `Meld`'
    method_options :force => :boolean
    def rm(url)
      name = extract_module_name url
      unless check_presence url
        say "Git tool #{url} does not exists.", :red
      end
      say "Removing git tool #{url}", :red

      delete_git_module name
      run "git rm --cached #{root}/git/#{name}"
      FileUtils.rm_rf "#{root}/git/#{name}"
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
