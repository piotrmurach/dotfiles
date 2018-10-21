#!/user/bin/ruby

module Dotfiles
  class Base < Thor
    include Thor::Actions
    Thor::Sandbox::Dotfiles::Base.source_root File.expand_path('../..', __FILE__)

    class_option :linkable_path, :type => :string

    namespace :dotfiles

    TOOLS = [
      'ack', 'zsh', 'tmux', 'grc', 'irssi'
    ]

    no_tasks do
      include ::Submodules

      # System properties

      def root
        File.expand_path('../..', __FILE__)
      end

      def user
        @user = %x["whoami"].chomp
      end

      def user_home
        Thor::Util.user_home
      end

      def define_linkable_dir(&block)
        @linkables = block.call
      end

      def extract_symlink_name(path)
        path.split('/').last.gsub('.link','')
      end

      def check_presence(name)
        system("which #{name}")
      end

      # Set source root for all subclasses
      def self.inherited base
        super
        base.source_root
      end
    end

    desc 'install [PATH]', 'Hook dotfiles into system-standard positions. Defaults to user home directory.'
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
        Dir.glob('**/*{.link}')
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
            say "Overwritting #{target}", :red
          end
          if backup || backup_all
            FileUtils.mv "#{home_dir}/.#{file}", "#{home_dir}/.#{file}.backup"
            say "Backing up #{target}", :green
          end
        end
        link_file linkable, target, options[:force]
        say "Symlinking #{linkable} to #{target}", :green
      end
    end
    default_task :install

    desc 'uninstall', 'Uninstall all dotfiles.'
    def uninstall
      linkables = if options.linkable_path?
        Dir.glob(options.linkable_path)
      else
        Dir.glob('*/**{.link}')
      end

      home_dir = File.expand_path("~#{user}")

      linkables.each do |linkable|
        file = extract_symlink_name linkable
        target = "#{home_dir}/.#{file}"

        if File.exists?(target)
          FileUtils.rm(target)
        end

        if File.exists?("#{home_dir}/.#{file}.backup")
          say "Restoring file  #{file}", :yellow
          run 'mv "$HOME/.#{file}.backup" "$HOME/.#{file}"'
        end
      end
    end

    desc 'update', 'Updates all dotfiles and modules'
    def update
      say "Updating .dotfiles", :green
      run "git pull --recurse-submodules"
      update_submodules
    end

    desc 'modules', 'Display available modules'
    def modules
      status
    end

    desc 'tools', 'Installs essential tools using homebrew'
    method_option :force, :type => :boolean, :aliases => "-f", :default => false
    def tools(tool=nil)
      if check_presence('brew') && !options[:force]
        say "Installing brew for #{user}", :green
        invoke "dotfiles:brew"
      end
      TOOLS.each do |tool|
        if check_presence(tool) && !options[:force]
          say "#{tool} is already installed, skipping. Run task with -f to force", :red
        else
          say "Installing #{tool}", :green
          run "brew install #{tool}"
        end
      end
    end
  end # Base
end # Dotfiles
