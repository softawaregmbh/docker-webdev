#!/bin/sh

if [ -f package.json ]; then
    npm install --loglevel warn
fi

exec "$@"
