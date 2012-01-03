#!/user/bin/ruby

module Dotfiles

  class Base < Thor
    include Thor::Actions

    class_option :linkable_path, :type => :string

    no_tasks do
      def root
        File.dirname(__FILE__)
      end

      def user
        @user = %x["whoami"].chomp
      end

      def define_linkable_dir &block
        @linkables = block.call
      end

      def extract_symlink_name path
        path.split('/').last.gsub('.link','')
      end
    end

    desc 'install', 'Hook dotfiles into system-standard positions.'
    def install
      skip_all = false
      overwirte_all = false
      backup_all = false

      linkables = if options.linkable_path?
        Dir.glob(options.linkable_path)
      else
        Dir.glob('*/**{.link}')
      end

      linkables.each do |linkable|
        file = extract_symlink_name linkable
        target = "#{ENV['HOME']}/.#{file}"

        if File.exists?(target) || File.symlink?(target)
          unless skip_all || overwrite_all || backup_all
            case ask("File already exists: #{target}, what do you want to do? \n [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all", :green)
              when 'o' then overwrite = true
              when 'b' then backup = true
              when 'O' then overwrite_all = true
              when 'B' then backup_all = true
              when 'S' then skip_all = true
              when 's' then next
            end
          end
          FileUtils.rm_rf(target) if overwrite || overwrite_all
          FileUtils.mv target, "#{target}.backup" if backup || backup_all
        end
        link_file file, target, options[:force]
      end
    end

    desc 'uninstall', 'Uninstall all dotfiles.'
    def uninstall
      linkables = if options.linkable_path?
        Dir.glob(options.linkable_path)
      else
        Dir.glob('*/**{.link}')
      end

      linkables.each do |linkable|
        file = extract_symlink_name linkable
        target = "#{ENV['HOME']}/.#{file}"

        if File.exists?(target)
          FileUtils.rm(target)
        end

        if File.exists?("#{ENV['HOME']}/.#{file}.backup")
          say "Restoring file  #{file}", :yellow
          run 'mv "$HOME/.#{file}.backup" "$HOME/.#{file}"'
        end
      end
    end

    desc 'brew', 'Installs homebrew package manager'
    def brew
      say "Installing homebrew for #{user}", :green
      run " /usr/bin/ruby -e \"$(curl -fsSL https://raw.github.com/gist/323731)\""
    end

    desc 'gcc', 'Installs GCC compiler'
    def gcc
      say "Installing gcc compiler for #{user}", :green
      run "curl https://github.com/downloads/kennethreitz/osx-gcc-installer/GCC-10.6.pkg > GCC-10.6.pkg"
    end
  end # Base

end # Dotfiles
