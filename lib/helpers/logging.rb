require "logger"

module LogHelper

  @@logger = Logger.new(STDOUT)

  def self.get_logger
    @@logger
  end

end
