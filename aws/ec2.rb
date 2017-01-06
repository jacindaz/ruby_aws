require_relative 'aws_base'

class EC2 < AwsBase
  attr_reader :ec2

  def initialize
    @ec2 = Aws::EC2::Client.new(region:'us-west-2')
  end
end
