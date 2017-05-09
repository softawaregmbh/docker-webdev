# specify the wanted node/npm version-tag as listed in https://hub.docker.com/r/library/node/tags/
FROM node:{{ node_version }}-alpine
LABEL maintainer "bernhard.mayr@softaware.at"

# add MicroBadger data
ARG VCS_REF
LABEL org.label-schema.vcs-ref=$VCS_REF \
      org.label-schema.vcs-url="https://github.com/softawaregmbh/docker-webdev"

# set path in a way, that local npm-modules (e.g. ng-cli) can be called like executables
ENV PATH="./node_modules/.bin:${PATH}"

# install bash
RUN apk --no-cache add bash

# set the working-directory
WORKDIR "/usr/src/app"

# prepare start-script
COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod a+rx /usr/local/bin/docker-entrypoint.sh

# prepare .profile
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd
COPY .bashrc /root/

# executing the start-script and dropping into a new bash session
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["bash"]
