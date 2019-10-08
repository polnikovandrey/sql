# $mysql-ctl cli;           # Start the CLI (command line interface)
CREATE DATABASE soap_shop;  # Create database with name
USE soap_shop;              # Select database for use
SELECT DATABASE();          # Show database currently used
DROP DATABASE soap_shop;    # Delete database by name
SELECT DATABASE();          # Note empty result after deletion of currently used database
SHOW DATABASES;             # List available (to logged user) databases