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
    create_table_ddl = create_table_command(table_name, schema_name)
    @connection.execute_ddl_query(create_table_ddl)
  end

  def generate_create_table_ddl(table_name, schema_name)
    generate_table_ddl_view

    @logger.info("Querying the admin.v_generate_tbl_ddl view for the create table command.")

    sql = "select ddl from admin.v_generate_tbl_ddl
       where tablename = '#{table_name}'
       and schemaname = '#{schema_name}'"

    @connection.execute_query_and_clean_up(sql, "ddl").join(" ")
  end

  private

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
