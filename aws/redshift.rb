require_relative 'aws_base'

class Redshift < AwsBase
  attr_reader :redshift

  def initialize
    # Credentials documentation:
    # http://docs.aws.amazon.com/sdk-for-ruby/v2/developer-guide/setup-config.html

    @redshift = Aws::Redshift::Client.new(region: 'us-east-1')
    @connection = PgConnect.new("redshift")
  end

  def redshift_clusters
    @redshift.describe_clusters.clusters
  end

  def generate_table_ddl_view
    sql = File.open(ENV["SQL_FILE_PATH"], 'rb') { |file| file.read }
    @connection.execute_query(sql)
  end

  def create_table_command(table_name, schema_name)
    sql = "select ddl from admin.v_generate_tbl_ddl where tablename = '#{table_name}' and schemaname = '#{schema_name}'"
    @connection.execute_query(sql)
  end
end
