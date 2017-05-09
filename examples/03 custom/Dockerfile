# specify the wanted node/npm version-tag as listed in https://hub.docker.com/r/library/node/tags/
FROM softaware/webdev:node-6.10.3

# install global npm packages without resulting implicit dependencies
RUN npm install -g npm-check

# expose required ports (e.g. Angular CLI)
EXPOSE 4200
