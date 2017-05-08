## softaware/webdev [(github)](https://github.com/softawaregmbh/docker-webdev)
> Our Container for Frontend-Webdevelopment based on node/npm.
The **main advantage** is the abstraction of the build-toolchain into a container, thus providing a consistent and reproducible developer experience across systems and platforms.
The `latest`-tag is omitted on purpose, because the idea of this container is to exactly specify the node and npm version you want to use.

### Versions


- **4.8.3:** [![](https://images.microbadger.com/badges/version/softaware/webdev:node-4.8.3.svg)](https://microbadger.com/images/softaware/webdev:node-4.8.3 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/softaware/webdev:node-4.8.3.svg)](https://microbadger.com/images/softaware/webdev:node-4.8.3 "Get your own image badge on microbadger.com")
- **6.10.2:** [![](https://images.microbadger.com/badges/version/softaware/webdev:node-6.10.2.svg)](https://microbadger.com/images/softaware/webdev:node-6.10.2 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/softaware/webdev:node-6.10.2.svg)](https://microbadger.com/images/softaware/webdev:node-6.10.2 "Get your own image badge on microbadger.com")
- **7.10.0:** [![](https://images.microbadger.com/badges/version/softaware/webdev:node-7.10.0.svg)](https://microbadger.com/images/softaware/webdev:node-7.10.0 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/softaware/webdev:node-7.10.0.svg)](https://microbadger.com/images/softaware/webdev:node-7.10.0 "Get your own image badge on microbadger.com")

like [*node releases*](https://nodejs.org/en/download/releases/) and [*node-docker tags*](https://hub.docker.com/r/library/node/)

### Usage
##### *standalone*
Directly start the container to run a specific set of npm/node/yarn version without the need to install it locally. Mapping the current folder with `-v ...`.
```
docker container run -it --rm -v ${pwd}:/usr/src/app softaware/webdev:node-6.10.2
```

##### *in a project (e.g. Angular CLI)*
```Dockerfile
FROM softaware/webdev:6.10.2
EXPOSE 4200
```
```
docker image build -t demo:webdev .
docker container run -it --rm -p 4200:4200 -v ${pwd}:/usr/src/app demo:webdev
```
