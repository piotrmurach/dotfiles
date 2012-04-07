#!/user/bin/ruby

module Dotfiles
  class Rvm < Base

    namespace :rvm

    desc 'setup', 'Installs RVM'
    def setup
      say "Installing rvm for #{user}", :green
      run "bash < <(curl -s https://rvm.beginrescueend.com/install/rvm)"
    end

    desc 'update', 'Updates RVM to newest version'
    def update
      say "Updating rvm", :green
      run "rvm get head"
    end

  end # Rvm
end # Dotfiles
