require_relative 'aws_base'

class Redshift < AwsBase
  attr_reader :redshift

  def initialize
    # Credentials documentation:
    # http://docs.aws.amazon.com/sdk-for-ruby/v2/developer-guide/setup-config.html

    @redshift = Aws::Redshift::Client.new(region: 'us-east-1')
    @connection = PgConnect.new("redshift")
    @logger = AwsLogger.new.logger
  end

  def run_create_table(table_name, schema_name)
    # Steps:
    #  => check if table has dependencies
    #  => display dependencies to stdout
    #  => ask if user still wants to continue
    #  => if not, quit
    #  => if yes, display each dependency again and that they will be dropped
    #  => run drop table if exists <TABLENAME> cascade

    create_table_ddl = create_table_command(table_name, schema_name)
    @connection.raw_result(create_table_ddl)

    # append distribution and sort keys to sql
    # run resulting sql to drop and re-create table
    # @connection.execute_query()
  end

  def redshift_clusters
    @redshift.describe_clusters.clusters
  end

  private

  def create_table_command(table_name, schema_name)
    generate_table_ddl_view

    @logger.info("Querying the admin.v_generate_tbl_ddl view for the create table command.")

    sql = "select ddl from admin.v_generate_tbl_ddl
       where tablename = '#{table_name}'
       and schemaname = '#{schema_name}'"
    @connection.raw_result(sql).column_values(0).join(" ")
  end

  def generate_table_ddl_view
    check_presence_or_create_schema("admin")

    @logger.info("Creating or replacing view admin.v_generate_tbl_ddl \nSource: https://github.com/awslabs/amazon-redshift-utils/blob/master/src/AdminViews/v_generate_tbl_ddl.sql")
    @connection.execute_query(
      File.open(ENV["SQL_FILE_PATH"], 'rb') { |file| file.read }
    )
  end

  def check_presence_or_create_schema(schema_name)
    schemas = @connection.execute_query("select * from pg_catalog.pg_namespace where nspname = '#{schema_name}'")

    if schemas.length == 0
      @logger.info("Creating #{schema_name} schema, does not exist.")
      @connection.execute_query("create schema if not exists #{schema_name}")
    else
      @logger.info("Admin #{schema_name} exists, not re-creating.")
    end
  end
end
