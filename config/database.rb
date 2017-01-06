require 'pg'
require 'pry'
require 'dotenv'
Dotenv.load

class PgConnect
  def initialize(type)
    @connect = pg_connection(type)
  end

  def execute_query(query)
    query_results = []
    @connect.exec(query) do |results|
      results.each{ |r| query_results << r["ddl"].strip }
    end

    query_results
  end

  private

  def pg_connection(type)
    case type
    when "redshift"
      PG::Connection.new(dbname: "mongoprod", port: ENV["REDSHIFT_PORT"], host: ENV["REDSHIFT_HOST"], user: ENV["REDSHIFT_USER"], password: ENV["REDSHIFT_PASSWORD"], connect_timeout: 10)
    when "localhost"
      PG::Connection.new(dbname: "entelo_development", host: "localhost", port: 5432 )
    else
      raise PgConnectError, "Unable to connect - type needs to be 'localhost' or 'redshift'."
    end
  end
end

class PgConnectError < RuntimeError
end
