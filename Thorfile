#!/user/bin/ruby

require 'fileutils'

module Dotfiles

  def self.load_thor_files dir
    Dir.chdir(dir) do
      thor_files = Dir.glob('**/*.thor')
      thor_files.each do |file|
        Thor::Util.load_thorfile file
      end
    end
  end

end # Dotfiles

Dotfiles.load_thor_files('lib')
