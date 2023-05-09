# TestLink 1.9.20

This is a project that creates a docker image for TestLink 1.9.20.

## How to use this image

### Start a MySQL instance

It's important to note that this image does not include a MySQL database. Instead, the intention is for you to provide the MySQL database as a separate container. This allows you to use a version of MySQL other than the one provided by this image.

When starting your MySQL instance, you will need to create a database and user for TestLink. You can do this by running the following commands:

```console
$ docker run --name some-mysql \
        -e MYSQL_ROOT_PASSWORD=root \
        -e MYSQL_USER=testlink \
        -e MYSQL_PASSWORD=testlink \
        -e MYSQL_DATABASE=testlink \
        -p 3306:3306 -d \
        mysql:5.7
```

### Start a TestLink instance

```console
docker run --name some-testlink \
      -p 8080:80 -d \
      asheldkr/testlink:1.9.20
```

### Docker Compose

You can also use docker-compose to start the TestLink and MySQL containers.

```yaml
version: '3'

services:
  testlink:
    image: asheldkr/testlink:1.9.20
    ports:
      - 8080:80
    depends_on:
      - mysql
    restart: always

  mysql:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_USER: testlink
      MYSQL_PASSWORD: testlink
      MYSQL_DATABASE: testlink
    ports:
      - 3306:3306
    restart: always
```

## Persis Data

In order to persist the data, you can mount a volume for the database on the host For example, you can mount the volume on the host as follows:

```console
$ docker run --name some-mysql \
        -e MYSQL_ROOT_PASSWORD=root \
        -e MYSQL_USER=testlink \
        -e MYSQL_PASSWORD=testlink \
        -e MYSQL_DATABASE=testlink \
        -v /my/own/datadir:/var/lib/mysql \
        -p 3306:3306 -d \
        mysql:5.7
```

o using docker compose

```yaml
version: '3'

services:
  testlink:
    image: asheldkr/testlink:1.9.20
    ports:
      - 8080:80
    depends_on:
      - mysql
    restart: always

  mysql:
    image: mysql:5.7
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_USER: testlink
      MYSQL_PASSWORD: testlink
      MYSQL_DATABASE: testlink
    volumes:
      - /my/own/datadir:/var/lib/mysql
    ports:
      - 3306:3306
    restart: always
```
