<h1 align="center">softaware/webdev</h1>
<div align="center">
  <strong>A container for a cross-platform and consistent Frontend-Development tooling platform based on node/npm.</strong>
</div>

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
    <a href="#motivation">
      Motivation
    </a>
    <span> | </span>
    <a href="https://github.com/softawaregmbh/docker-webdev/tree/master/examples">
      Examples
    </a>
    <span> | </span>
    <a href="https://github.com/softawaregmbh/docker-webdev">
      GitHub
    </a>
    <span> | </span>
    <a href="https://hub.docker.com/r/softaware/webdev/">
      Docker Hub
    </a>
  </h3>
</div>


## Versions¹ and Sizes
| Node² | Version | Base | Angular³ |
| :---: | :---: | :---: | :---: |
| **4** | `4.8.3` | [![](https://images.microbadger.com/badges/image/softaware/webdev:node-4.8.3.svg)](https://microbadger.com/images/softaware/webdev:node-4.8.3 "Get your own image badge on microbadger.com") | - |
| **6** | `6.10.3` | [![](https://images.microbadger.com/badges/image/softaware/webdev:node-6.10.3.svg)](https://microbadger.com/images/softaware/webdev:node-6.10.3 "Get your own image badge on microbadger.com") | [![](https://images.microbadger.com/badges/image/softaware/webdev:angular-6.10.3.svg)](https://microbadger.com/images/softaware/webdev:angular-6.10.3 "Get your own image badge on microbadger.com") |
| 7 | `7.10.0` | [![](https://images.microbadger.com/badges/image/softaware/webdev:node-7.10.0.svg)](https://microbadger.com/images/softaware/webdev:node-7.10.0 "Get your own image badge on microbadger.com") | - |

¹ You can see all available versions on [Docker Hub](https://hub.docker.com/r/softaware/webdev/tags/). The images are tagged according to the `npm`/`node` releases like [node releases](https://nodejs.org/en/download/releases/) and [node-docker tags](https://hub.docker.com/r/library/node/).

² more info here: [Node.js LTS Working Group](https://github.com/nodejs/LTS)

³ no Angular included, just exposes port 4200 (see: [`Dockerfile`](https://github.com/softawaregmbh/docker-webdev/tree/master/image/angular/Dockerfile))


## Usage *([more](https://github.com/softawaregmbh/docker-webdev/tree/master/examples))*
Directly start the container to run a specific set of `npm`/`node`/`yarn` version without the need to install it locally. Mapping the current folder with `-v ...`. Choose the version according to the [available tags](https://hub.docker.com/r/softaware/webdev/tags/).
```
docker container run -it --rm -v ${pwd}:/usr/src/app softaware/webdev:node-6.10.3
```

The container is designed to use your project folder as a mapped volume. This enables some of your team members not to use the container if the host [`npm`/`node` versions match](#specifying-node-and-npm-versions-explicitly).


## Motivation
Developing multiple Web-Applications (especially old-ones) can get really tricky due to different `npm`/`node`-versions. Solutions like [nvm](https://github.com/creationix/nvm) are not cross-platform and introduce an implicit depencency.
We thought that Docker and Container Solutions would allow us to commit our parts development environment with our source-code and make the used versions explicit.
Thanks to the great official node Docker image: [`library/node`](https://hub.docker.com/_/node/), this task was not hard to accomplish.
A `latest`-tag is omitted on purpose, because the idea of this container is to exactly specify the node and npm version you want to use.
A few problems we faced and their solutions are described in [caveats](#caveats).

### Tips
#### Specifying `node` and `npm` versions explicitly
To make sure that only specific versions of `node` and `npm` are used it is possible to specify the needed versions in `package.json`.
Combined with `engine-strict = true` in `.npmrc` node complains if these versions are not compatible and prevents you from version incompatibilities.

```
// package.json
"engines": {
  "node": "7.8.0", // or "7.x"; "5 - 7"; ">= 5"; more info: https://docs.npmjs.com/misc/semver
  "npm": "4.2.0"
}
```
```
// .npmrc
engine-strict = true
```

### What it does?
The [`Dockerfile`](https://github.com/softawaregmbh/docker-webdev/tree/master/image/node/Dockerfile) extends `node:x.x.x-alpine` adds `bash`, modifies it's prompt slightly and [extends the path](https://github.com/softawaregmbh/docker-webdev/tree/master/image/node/Dockerfile#L6) to execute `devDependencies` as executables. Additionally [npm-completion](https://docs.npmjs.com/cli/completion) is enabled.

The **main advantage** is the abstraction of the build-toolchain into a container, thus providing a consistent and reproducible developer experience across systems and platforms.


## Caveats
### Shared `node_modules` folder
We decided to share the `node_modules` folder too, because otherwise IDEs like VS Code do not get Type-Informations for Autocomplete if the installed `node_modules` are encapsulated by the container. As a result you may have problems if *native node modules* are used and your Host-OS is not Linux when you try to start the application outside of the container.

### Angular CLI/Webpack Live Reloading (Windows)
Because of a [problem](https://docs.docker.com/docker-for-windows/troubleshoot/#troubleshooting) with `inotify` file changes do not reflect in the container for mounted directories on Windows. This can be solved with setting 
[`poll`](https://github.com/angular/angular-cli/pull/1814#issuecomment-241854816) and [`host`](https://github.com/angular/angular-cli/issues/4471) in `.angular-cli.json` like the following snippet shows:
```json
// .angular-cli.json
"defaults": {
  "poll": 3000,
  "serve": {
    "host": "0.0.0.0"
  }
}
```


## Development
The containers are created through [`create-image.ps1`](https://github.com/softawaregmbh/docker-webdev/tree/master/create-image.ps1). Please update the information in this [README](https://github.com/softawaregmbh/docker-webdev/blob/master/README.md) according to the new versions.
### Options
```
// Parameters
[1] image-type     # one of the subfolders in ./image
[2] node-version   # node-version according to https://hub.docker.com/r/library/node/

// Flags
-silent    # omit Docker-Output only show success and error messages
-publish   # publish the created Image to Docker-Hub; `docker login` necessary
```

### Example
```powershell
# create only
> .\create-image.ps1 node 6.10.3 -silent
softaware/webdev:node-6.10.3 created successfully

# create and publish
> .\create-image.ps1 node 6.10.3 -silent -publish
softaware/webdev:node-6.10.3 created successfully
softaware/webdev:node-6.10.3 published successfully
```