require 'logger'
require 'date'

class AwsLogger
  attr_reader :logger

  def initialize
    @logger = Logger.new("#{Date.today.to_s}.log", 10, 'daily')
  end
end
