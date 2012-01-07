$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../../*')
require 'aruba/cucumber'
require 'fileutils'
require 'rspec/expectations'

module ThorHelpers
  def home_dir
    File.expand_path("~/")
  end
end

World(ThorHelpers)
