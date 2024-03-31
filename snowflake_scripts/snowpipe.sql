-- Creating our Pipe Schema for storing all pipes
CREATE OR REPLACE SCHEMA MANAGE_DB.pipes

-- Define pipe
CREATE OR REPLACE pipe MANAGE_DB.pipes.realestate_pipe
auto_ingest = TRUE
AS
COPY INTO REAL_ESTATE_DB.PUBLIC.raw_real_estate
FROM (
  SELECT $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
  FROM @MANAGE_DB.external_stages.csv_folder
)

/*Describe the pipe to see the code to connect the trigger Snowpipe and 
create event notification in S3 Bucket*/
DESC pipe realestate_pipe