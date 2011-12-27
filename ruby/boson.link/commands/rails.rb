module RailsLib
  def self.append_features(mod)
    super if ENV['RAILS_ENV'] || defined? Rails
  end

  # TODO setupd independent rails version app setup
  # add aliases
  def self.new

  end

  # TODO setup independent console method
  def self.console

  end

  def self.server

  end
end # RailsLib
