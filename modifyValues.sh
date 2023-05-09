#!/bin/bash
#
# Autor: vasquezpalominoashel@gmail.com
# Description: Modify values for the connection in config_db.inc.php

sed -i "s/define('DB_USER', '');/define('DB_USER', '$TL_DB_USER');/g" /var/www/html/$CONFIG_DB_FILE && \
sed -i "s/define('DB_PASS', '');/define('DB_PASS', '$TL_DB_PASSWD');/g" /var/www/html/$CONFIG_DB_FILE && \
sed -i "s/define('DB_HOST', '');/define('DB_HOST', '$TL_DB_HOST');/g" /var/www/html/$CONFIG_DB_FILE && \
sed -i "s/define('DB_NAME', '');/define('DB_NAME', '$TL_DB_NAME');/g" /var/www/html/$CONFIG_DB_FILE && \
sed -i "s/define('DB_PORT', '');/define('DB_PORT', '$TL_DB_PORT');/g" /var/www/html/$CONFIG_DB_FILE
