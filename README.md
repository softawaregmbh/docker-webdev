<h1 align="center">softaware/webdev</h1>
<div align="center">
  <strong>A container for a cross-platform and consistent Frontend-Development tooling platform based on node/npm.</strong>
</div>

<div align="center">
  <h3>
    <a href="#usage-more">
      Usage
    </a>
    <span> | </span>
    <a href="#versions-and-sizes">
      Versions
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
    <span> | </span>
    <a href="https://softaware.at/codeaware/2017/05/23/consistent-npm-development-environments-using-docker.html">
      Blog Article
    </a>
  </h3>
</div>


## Usage *([more](https://github.com/softawaregmbh/docker-webdev/tree/master/examples))*
> The container is intended to be used for the following two cases:

### (1) Running a specific version of node or npm without local installation (e.g. `npm init`)
Directly start the container to run a specific set of `npm`/`node`/`yarn` version without the need to install these locally on your system. Map the current folder with `-v ...`. Choose the version according to the [available tags](https://hub.docker.com/r/softaware/webdev/tags/).

**Example:** To start a bash with *npm 3.10.10* in your current directory you can run the following command.
```
docker container run -it --rm -v ${pwd}:/usr/src/app softaware/webdev:alpine-6.10.3
```

Now you can run whatever `npm`/`node`/`yarn` commands you want. Let's say you want to setup a project, just run `npm init` in the container.
Afterwards please continue with *[Adding the container to an existing project](#2-adding-the-container-to-an-existing-project)* using the same node version.

### (2) Adding the container to an existing project
The container is way more powerful if it is added as a versioned dependency to an existing project.
1. As shown in the [examples](https://github.com/softawaregmbh/docker-webdev/tree/master/examples) create a script for your shell that starts the container you want to use.
2. Add this script to your repository.
3. Now you can start your development environment with `<scriptname> ENTER` and you are good to go.
4. Don't forget to document the name and the usage of the script in your README to spread your knowledge.

### *Additional Information*
- The container is designed to use your project folder as a mapped volume. This enables some of your team members not to use the container if the host [`npm`/`node` versions match](#specifying-node-and-npm-versions-explicitly).
- If your Container OS is different than your Host OS delete the `node_modules`-directory before starting the container. ([more info](#shared-node_modules-folder))
- Be aware of your IDE automatically running `npm install` and messing up your `node_modules`! (e.g. [Visual Studio](http://stackoverflow.com/questions/31876984/how-can-i-disable-npm-package-restore-in-visual-studio-2015))
- How to [enable file change detection](#angular-cliwebpack-live-reloading-windows).
- The root directory of your application in the container is `/usr/src/app`.
- Try to override the container's startup command with an npm command. As an example you can automatically run `npm start` in the container by running the container with `... softaware/webdev:<linux>-<version> npm start` in your shell script.
- Previous versions of the container contained [exposed ports](https://github.com/softawaregmbh/docker-webdev/commit/1f8a07c32617909b4c64c8d1729bdd1cc4fb5e14). Because [exposing a port is not necessary](https://www.ctl.io/developers/blog/post/docker-networking-rules/) for publishing it (`docker container run -p <host:container>`), these do not exist anymore. Just choose your desired [version](#versions-and-sizes) and [**publish** the port of the web server](https://docs.docker.com/engine/reference/commandline/run/#publish-or-expose-port--p-expose) you use with `-p <...>`.


## Versions¹ and Sizes
| Node²  | Latest Version |                                                                         Alpine                                                                         |                                                                         Debian                                                                         |
| :----: | :------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------: | :----------------------------------------------------------------------------------------------------------------------------------------------------: |
| **4**  |    `4.8.3`     |   [![](https://images.microbadger.com/badges/image/softaware/webdev:alpine-4.8.3.svg)](https://microbadger.com/images/softaware/webdev:alpine-4.8.3)   |   [![](https://images.microbadger.com/badges/image/softaware/webdev:debian-4.8.3.svg)](https://microbadger.com/images/softaware/webdev:debian-4.8.3)   |
| **6**  |    `6.11.0`    |  [![](https://images.microbadger.com/badges/image/softaware/webdev:alpine-6.11.0.svg)](https://microbadger.com/images/softaware/webdev:alpine-6.11.0)  |  [![](https://images.microbadger.com/badges/image/softaware/webdev:debian-6.11.0.svg)](https://microbadger.com/images/softaware/webdev:debian-6.11.0)  |
|   7    |    `7.10.0`    |  [![](https://images.microbadger.com/badges/image/softaware/webdev:alpine-7.10.0.svg)](https://microbadger.com/images/softaware/webdev:alpine-7.10.0)  |  [![](https://images.microbadger.com/badges/image/softaware/webdev:debian-7.10.0.svg)](https://microbadger.com/images/softaware/webdev:debian-7.10.0)  |
| **8**  |    `8.9.4`     |   [![](https://images.microbadger.com/badges/image/softaware/webdev:alpine-8.9.4.svg)](https://microbadger.com/images/softaware/webdev:alpine-8.9.4)   |   [![](https://images.microbadger.com/badges/image/softaware/webdev:debian-8.9.4.svg)](https://microbadger.com/images/softaware/webdev:debian-8.9.4)   |
|   9    |    `9.7.1`     |   [![](https://images.microbadger.com/badges/image/softaware/webdev:alpine-9.7.1.svg)](https://microbadger.com/images/softaware/webdev:alpine-9.7.1)   |   [![](https://images.microbadger.com/badges/image/softaware/webdev:debian-9.7.1.svg)](https://microbadger.com/images/softaware/webdev:debian-9.7.1)   |
| **10** |   `10.19.0`    | [![](https://images.microbadger.com/badges/image/softaware/webdev:alpine-10.19.0.svg)](https://microbadger.com/images/softaware/webdev:alpine-10.19.0) | [![](https://images.microbadger.com/badges/image/softaware/webdev:debian-10.19.0.svg)](https://microbadger.com/images/softaware/webdev:debian-10.19.0) |

¹ You can see all available versions on [Docker Hub](https://hub.docker.com/r/softaware/webdev/tags/). The images are tagged according to the `npm`/`node` releases like [node releases](https://nodejs.org/en/download/releases/) and [node-docker tags](https://hub.docker.com/r/library/node/).

² more info here: [Node.js LTS Working Group](https://github.com/nodejs/LTS)

### `alpine-x.x.x`
We recommend to use the alpine image because of the *small image size*!
Because alpine linux uses `musl libc` instead of `glibc` you may run into problems. More information can be found [here](https://github.com/nodejs/docker-node#nodealpine).
We had an [issue](https://github.com/sass/node-sass/issues/1858) with Kendo UI and [node-sass](https://github.com/sass/node-sass) on alpine.
This is the reason why [`debian-x.x.x`](#debian-xxx) exists.

### `debian-x.x.x`
In addition to the *alpine image* a full *debian image* based on the full [official Docker node image](https://github.com/nodejs/docker-node#nodeversion) is available.


## Motivation
Developing multiple Web-Applications (especially old-ones) can get really tricky due to different `npm`/`node`-versions. Solutions like [nvm](https://github.com/creationix/nvm) are not cross-platform and introduce an implicit depencency.
We thought that a container would allow us to commit our development environment with our source-code and explicitly define the used versions.
Thanks to the great official node Docker image: [`library/node`](https://hub.docker.com/_/node/), this task was not too hard to accomplish.

Daniel Demmel released an [excellent article](https://www.smashingmagazine.com/2016/04/stop-installing-your-webdev-environment-locally-with-docker/) on smashingmagazine where he mentions even more reasons and a bit of the history why containerizing your webdevelopment environment makes perfectly sense.
A `latest`-tag is omitted on purpose, because the idea of this container is to exactly specify the node and npm version you want to use.
A few problems we faced and their solutions are described in [caveats](#caveats).

### What it does?
The [`Dockerfile`](https://github.com/softawaregmbh/docker-webdev/tree/master/images/Dockerfile.alpine) extends `node:x.x.x-alpine` (same with *debian*) adds `bash`, modifies it's prompt slightly and [extends the path](https://github.com/softawaregmbh/docker-webdev/tree/master/images/Dockerfile.alpine#L6) to execute `devDependencies` as executables. Additionally [npm-completion](https://docs.npmjs.com/cli/completion) is enabled.

The **main advantage** is the abstraction of the build-toolchain into a container, thus providing a consistent and reproducible developer experience across systems and platforms.

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


## Caveats
### Shared `node_modules` folder
We decided to share the `node_modules` folder too, because otherwise IDEs like VS Code do not get Type-Informations for Autocomplete if the installed `node_modules` are encapsulated by the container. As a result you may have problems if *native node modules* are used and your Host-OS is not Linux when you try to start the application outside of the container.

### Angular CLI/Webpack Live Reloading (Windows)
Making the webserver of Angular CLI (or any other Webpack-based project) working, requires you to set the [`host`](https://github.com/angular/angular-cli/issues/4471)-setting in `.angular-cli.json` to `0.0.0.0`. Now the webserver binds to every available network interface, thus enabling access to it from the host.
Because of a [problem](https://docs.docker.com/docker-for-windows/troubleshoot/#inotify-on-shared-drives-does-not-work) with `inotify` file changes do not reflect in the container for mounted directories on Windows. This can be solved by enabling polling with setting 
[`poll`](https://github.com/angular/angular-cli/pull/1814#issuecomment-241854816) in `.angular-cli.json` like the following snippet shows:
```json
// .angular-cli.json
"defaults": {
  "poll": 3000,
  "serve": {
    "host": "0.0.0.0"
  }
}
```
*The same problems may arise if you are using `gulp` or `webpack` directly!*


## Development
The containers are created through [`create-image.ps1`](https://github.com/softawaregmbh/docker-webdev/tree/master/create-image.ps1). Please update the version information in this [README](https://github.com/softawaregmbh/docker-webdev/blob/master/README.md) according to the new versions.

> **IMPORTANT:** Make sure that all the files used in the container (`.bashrc`, `docker-entrypoint.sh`, ...) use `LF` as their line-ending. Otherwise you will get really ugly errors at *container runtime*!

### Options
```
// Parameters
[1] node-version        # node-version according to https://hub.docker.com/r/library/node/

// Flags
-silent    # omit Docker-Output only show success and error messages
-publish   # publish the created Image to Docker-Hub; `docker login` necessary
```

### Example
```powershell
# create only
> .\create-image.ps1 4.8.3 -silent
softaware/webdev:alpine-4.8.3 created successfully
softaware/webdev:debian-4.8.3 created successfully

# create and publish
> .\create-image.ps1 8.0.0 -silent -publish
softaware/webdev:alpine-8.0.0 created successfully
softaware/webdev:alpine-8.0.0 published successfully
softaware/webdev:debian-8.0.0 created successfully
softaware/webdev:debian-8.0.0 published successfully
```
