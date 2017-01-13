## LearnUp Redshift

### Tools
  * [AWS Ruby SDK](https://aws.amazon.com/sdk-for-ruby/) to connect to our redshift cluster
  * [PG gem](https://github.com/ged/ruby-pg) to run queries inside our redshift cluster
 * [AWS Labs redshift utilities](https://github.com/awslabs/amazon-redshift-utils) to create a view that contains the create table data definition language (ddl) for generating the current table schema

### Setting up your AWS credentials
If you'd like to use dot env, add a `.env` file and add your access and secret keys there. Otherwise you can directly add to the `aws_credentials.rb` file, or export them as environment variables.

To generate a new access and secret key, you will need to sign into the AWS console, then click on your username in the top right, and click on "My Security Credentials". Ideally you create an IAM user that has specific permissions, so that your keys don't have whitelist access to everything on AWS. This can be dangerous, since you can easily spin up/terminate instances via the SDK.

This code will expect these 2 keys:
`Aws::Credentials.new(ENV['AWS_ACCESS_KEY'], ENV['AWS_SECRET_KEY']`

### Generating create table DDL from Redshift
For example:

Open the ruby console: `ruby console.rb`

```r = Redshift.new
r.generate_create_table_ddl("applications", "fivetran_learnup_prod")```

```r = Redshift.new
r.generate_create_table_ddl("table_name", "schema_name")```
