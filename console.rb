require_relative 'aws/aws_base'
require_relative 'aws/ec2'
require_relative 'aws/redshift'
require_relative 'config/database'

def console
  binding.pry
end

console
