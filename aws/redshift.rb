class Redshift < AwsBase
  attr_reader :ec2_instance

  def initialize
    # Credentials documentation:
    # http://docs.aws.amazon.com/sdk-for-ruby/v2/developer-guide/setup-config.html

    @ec2 = Aws::Redshift::Client.new(region: 'us-east-1')
  end

  def ec2_instance
     @redshift.describe_clusters.clusters
   end
end
