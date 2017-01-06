require 'aws-sdk'
require 'pry'

require 'dotenv'
Dotenv.load

require_relative '../config/aws_credentials'
require_relative '../config/logger'

class AwsBase
end
