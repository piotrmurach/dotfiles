#!/user/bin/ruby

require 'thor'
require 'fileutils'
require './lib/submodules'

module Dotfiles

  def self.load_thor_files(dir)
    Dir.chdir(dir) do
      thor_files = Dir.glob('**/*.thor')
      thor_files.each do |file|
        unless file =~ /.*base.*/
          Thor::Util.load_thorfile file
        end
      end
    end
  end

end # Dotfiles

Thor::Util.load_thorfile(File.expand_path('../lib/base.thor', __FILE__))
Dotfiles.load_thor_files(File.expand_path('../lib', __FILE__))
