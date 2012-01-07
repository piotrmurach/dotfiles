#!/user/bin/ruby

module Dotfiles

  class Base < Thor
    include Thor::Actions
    Thor::Sandbox::Dotfiles::Base.source_root File.expand_path('../..', __FILE__)

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

      def self.inherited base
        super

        base.source_root
      end
    end

    desc 'install [PATH]', 'Hook dotfiles into system-standard positions.'
    method_option :skip_all, :type => :boolean, :aliases => "-s",
                  :default => :false,
                  :desc => "Skip dotfiles that already exist"
    method_option :backup_all, :type => :boolean, :aliases => "-b",
                  :default => :false,
                  :desc => "Backup dotfiles that already exist"
    method_option :overwrite_all, :type => :boolean, :aliases => "-o",
                  :default => :false,
                  :desc => "Backup dotfiles that already exist"
    method_option :force, :type => :boolean, :aliases => "-f",
                  :default => :false
    def install(path = nil)
      skip_all = false
      overwrite_all = false
      backup_all = false

      linkables = if options.linkable_path?
        Dir.glob(options.linkable_path)
      else
        Dir.glob('*/**{.link}')
      end

      home_dir = path ? path.to_s : File.expand_path("~#{user}")

      linkables.each do |linkable|
        overwrite = false
        backup = false

        file = extract_symlink_name linkable
        target = "#{home_dir}/.#{file}"

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
          if overwrite || overwrite_all
            FileUtils.rm_rf(target)
            say("Overwritting #{target}", :red)
          end
          if backup || backup_all
            FileUtils.mv "#{home_dir}/.#{file}", "#{home_dir}/.#{file}.backup"
            say("Backing up #{target}", :green)
          end
        end
        link_file linkable, target, options[:force]
        say("Symlinking #{linkable} to #{target}", :green)
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
