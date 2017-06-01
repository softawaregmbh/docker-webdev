#!/bin/sh

if [ -f package.json ]; then
    if [ -d node_modules ]; then
        printf "Checking npm packages...\n"
    else
        printf "Installing npm packages...\n"
    fi
    npm install --loglevel warn
else
    printf "No \`package.json\` found, you may run \`npm init\` now."
fi

exec "$@"
