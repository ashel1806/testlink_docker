#!/bin/bash
#
# Autor: vasquezpalominoashel@gmail.com
# Description: Check if the data has already exist in the database

# Check if the database is empty
if [ -z "$(mysql -u $TL_DB_USER -p$TL_DB_PASSWD -h $TL_DB_HOST -P $TL_DB_PORT $TL_DB_NAME -e "SHOW TABLES;" | grep -v Tables_in_)" ]; then
    echo "The database is empty"
    echo "Providing privileges..."
    mysql -u $TL_DB_USER -p$TL_DB_PASSWD -h $TL_DB_HOST -P $TL_DB_PORT $TL_DB_NAME < $DB_TL_PRIVILEGES
    echo "Creating tables..."
    mysql -u $TL_DB_USER -p$TL_DB_PASSWD -h $TL_DB_HOST -P $TL_DB_PORT $TL_DB_NAME < $DB_TL_TABLES
    echo "Filling tables..."
    mysql -u $TL_DB_USER -p$TL_DB_PASSWD -h $TL_DB_HOST -P $TL_DB_PORT $TL_DB_NAME < $DB_TL_DATA
    echo "Tables created!!"
else
    echo "The database is not empty"
fi
