require 'pry'
require 'aws-sdk'

require_relative 'aws_credentials'

class AwsRedshift
  attr_reader :redshift

  def initialize
    # Credentials documentation:
    # http://docs.aws.amazon.com/sdk-for-ruby/v2/developer-guide/setup-config.html

    @redshift = Aws::Redshift::Client.new(region: 'us-east-1')
  end

  def redshift_clusters
     @redshift.describe_clusters.clusters
   end
end
