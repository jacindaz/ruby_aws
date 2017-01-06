## Playing with AWS public data sets!

* create EC2 instance
* load in data from https://aws.amazon.com/datasets/million-song-dataset/
* do something with it!


## Redshift to do's:
 * https://github.com/awslabs/amazon-redshift-utils/tree/master/src/AdminViews
 * pull latest source from ^^^
 * run the sql in this utility, which will regenerate this view:
 *  => v_generate_tbl_ddl.sql
 * query the view for the "create table" command
 * select ddl from admin.v_generate_tbl_ddl where tablename = 'applications' and schemaname = 'fivetran_learnup_prod';

## Logging:
 * need to add logging everywhere to monitor progress at each step
 * also, need a YUGE WARNING when executing drop table
 * fivetran will take some time to re-sync data
 * so there will be a delay, that table will be empty for a few hours, or up to 24 hours depending on how big the table is, and how long it takes fivetran to sync
