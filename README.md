# TORCIDA LEGAL

#### Intallation for development and maintenance
This system uses docker and docker-compose for development and testing, download it [here].
Clone this repository open the terminal in the folder that you cloned, and build an run the docker container.

```sh
$ docker-compose build
$ docker-compose up
```

Then create and migrate all databases

```sh
$ docker-compose run web rails db:create db:migrate
```

Now you have your application up and running at `http://localhost:3000` or `http://0.0.0.0:3000`

If you want to customize docker docker you can change the docker-compose and Dockerfile located at your main folder, for more instruction see the [Docker Documentation].

#### Rest Api documentation

You can find all the methods descriptions at `http://localhost/apipie`


[here]: <http://docker.com>
[Docker Documentation]: <https://docs.docker.com/>