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
