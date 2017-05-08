# softaware/webdev [(github)](https://github.com/softawaregmbh/docker-webdev)
> Our Container for Frontend-Webdevelopment based on node/npm.
The **main advantage** is the abstraction of the build-toolchain into a container, thus providing a consistent and reproducible developer experience across systems and platforms.
The `latest`-tag is omitted on purpose, because the idea of this container is to exactly specify the node and npm version you want to use.

<div align="center">
  <h3>
    <a href="#versions">
      Versions
    </a>
    <span> | </span>
    <a href="#usage">
      Usage
    </a>
    <span> | </span>
    <a href="./motivation">
      Motivation
    </a>
    <span> | </span>
    <a href="./example">
      Example
    </a>
  </h3>
</div>

## Versions
### *latest*
- **4.8.3:** [![](https://images.microbadger.com/badges/version/softaware/webdev:node-4.8.3.svg)](https://microbadger.com/images/softaware/webdev:node-4.8.3 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/softaware/webdev:node-4.8.3.svg)](https://microbadger.com/images/softaware/webdev:node-4.8.3 "Get your own image badge on microbadger.com")
- **6.10.3:** [![](https://images.microbadger.com/badges/version/softaware/webdev:node-6.10.3.svg)](https://microbadger.com/images/softaware/webdev:node-6.10.3 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/softaware/webdev:node-6.10.3.svg)](https://microbadger.com/images/softaware/webdev:node-6.10.3 "Get your own image badge on microbadger.com")
- **7.10.0:** [![](https://images.microbadger.com/badges/version/softaware/webdev:node-7.10.0.svg)](https://microbadger.com/images/softaware/webdev:node-7.10.0 "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/image/softaware/webdev:node-7.10.0.svg)](https://microbadger.com/images/softaware/webdev:node-7.10.0 "Get your own image badge on microbadger.com")

### *all versions*
You can see all available versions in the [Docker Hub (Tags)](https://hub.docker.com/r/softaware/webdev/tags/). The images are tagged according to the node/npm releases like [*node releases*](https://nodejs.org/en/download/releases/) and [*node-docker tags*](https://hub.docker.com/r/library/node/).


## Usage
### *standalone*
Directly start the container to run a specific set of npm/node/yarn version without the need to install it locally. Mapping the current folder with `-v ...`.
```
docker container run -it --rm -v ${pwd}:/usr/src/app softaware/webdev:node-6.10.2
```

### *in a project (e.g. Angular CLI)*
```Dockerfile
# --- Dockerfile ---
FROM softaware/webdev:6.10.2
EXPOSE 4200
```
```bash
# --- run.ps1 ---
docker image build -t demo:webdev .
docker container run -it --rm -p 4200:4200 -v ${pwd}:/usr/src/app demo:webdev
```

### *real-world example*
`./example`
