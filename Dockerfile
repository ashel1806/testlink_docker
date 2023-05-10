FROM php:7.2-apache

# Required dependencies
RUN apt-get update && apt-get install -y \
    git \
    libpng-dev \
    libxml2-dev \
    libzip-dev \
    gnupg \
    lsb-release \
    unzip \
    wget \
    && docker-php-ext-install pdo_mysql gd soap zip  mysqli \
    && a2enmod rewrite

# Installing mysql to connect to the database
RUN wget -O /tmp/mysql-apt-config_0.8.25-1_all.deb \
    https://dev.mysql.com/get/mysql-apt-config_0.8.25-1_all.deb && \
    dpkg -i /tmp/mysql-apt-config_0.8.25-1_all.deb && \
    apt-get update && \
    apt-get install -y mariadb-server

# Environment variables to build the image (NOT CHANGE)
ENV TL_DIR=/opt/testlink \
    TL_REPO="https://github.com/TestLinkOpenSourceTRMS/testlink-code.git" \
    TL_BRANCH="testlink_1_9_20_fixed" \
    CONFIG_DB_FILE="config_db.inc.php" \
    MODIFY_CONFIG_DB_FILE="modifyValues.sh" \
    LOAD_DATA_FILE="loadData.sh" \
    PRIVILEGES_FILE="privileges.sql" \
    # Files to be loaded into the database
    DB_TL_TABLES=/var/www/html/install/sql/mysql/testlink_create_tables.sql \
    DB_TL_DATA=/var/www/html/install/sql/mysql/testlink_create_default_data.sql \
    # Default values of the connection to the database
    TL_DB_USER="testlink" \
    TL_DB_PASSWD="testlink" \
    TL_DB_HOST="host.docker.internal" \
    TL_DB_NAME="testlink" \
    TL_DB_PORT="3306"

# Downloading TestLink from their repo
RUN git clone -b ${TL_BRANCH} ${TL_REPO} ${TL_DIR} && \
    rm -rf ${TL_DIR}/.git && \
    mv ${TL_DIR}/* /var/www/html/

# Copying the config_db.inc.php to the project
COPY ${CONFIG_DB_FILE} /var/www/html/

# Copying script to modify the values of the connection to the database
# in the config_db.inc.php file
COPY ${MODIFY_CONFIG_DB_FILE} ${TL_DIR}
RUN chmod ug+x ${TL_DIR}/${MODIFY_CONFIG_DB_FILE} && \
    ${TL_DIR}/${MODIFY_CONFIG_DB_FILE}

# Copying script to load the data into the database
COPY ${LOAD_DATA_FILE} ${PRIVILEGES_FILE} ${TL_DIR}
RUN chmod ug+x ${TL_DIR}/${LOAD_DATA_FILE} && \
    ${TL_DIR}/${LOAD_DATA_FILE}

# Changing the permissions to serve TestLink propertly
RUN chown -R www-data:www-data /var/www/html
