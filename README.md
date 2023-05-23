# TestLink 1.9.20

This is a project that creates a docker image for TestLink 1.9.20.

## How to use this image

### Clone this repository

```console
$ git clone https://github.com/ashel1806/testlink_docker.git
```

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

*Note: Don´t modify the values of the environment variables. If you do, you will need to modify the file `config_db.inc.php` and the `Dockerfile`.*

### Build the TestLink-docker image

```console
$ cd testlink_docker

$ docker build -t testlink:1.9.20 .
```

### Run the TestLink-docker image

```console
$ docker run --name some-testlink -p 8080:80 -d testlink:1.9.20
```

## Go the TestLink homepage

Open your browser and go to `http://localhost:8080`. The credentials are `admin` and `admin`.
