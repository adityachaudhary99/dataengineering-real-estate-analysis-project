-- First, we create a table for the data to be loaded
// Create table first
CREATE OR REPLACE TABLE REAL_ESTATE_DB.PUBLIC.raw_real_estate(
  serial_number INTEGER,
  list_year INTEGER,
  date_recorded DATE,
  town STRING,
  address STRING,
  accessed_value FLOAT,
  sale_amount FLOAT,
  sales_ratio FLOAT,
  property_type STRING,
  residential_type STRING
)


-- Create file format object
CREATE OR REPLACE file format MANAGE_DB.file_formats.csv_fileformat
    type = csv
    field_delimiter = ','
    skip_header = 1
    null_if = ('NULL','null')
    empty_field_as_null = TRUE
    FIELD_OPTIONALLY_ENCLOSED_BY = '"' ;

/* FIELD_OPTIONALLY_ENCLOSED_BY = '"' was used to handle the error 
"Field delimiter ',' found while expecting record delimiter '\n'"
 while loading CSV data*/
 

/* Create a stage(csv_folder) object that references the storage 
integration object and the file format object*/  
CREATE OR REPLACE stage MANAGE_DB.external_stages.csv_folder
    URL = 's3://bucket-911/csv/'
    STORAGE_INTEGRATION = s3_int
    FILE_FORMAT = MANAGE_DB.file_formats.csv_fileformat
    COMMENT = 'Nice'


-- Load data from staged files into the target table with the Copy command.      
COPY INTO REAL_ESTATE_DB.PUBLIC.raw_real_estate
FROM (
  SELECT $1, $2, $3, $4, $5, $6, $7, $8, $9, $10
  FROM @MANAGE_DB.external_stages.csv_folder
)

-- View the Data.      

SELECT * FROM REAL_ESTATE_DB.PUBLIC.raw_real_estate