#!/bin/bash

composer install

git init

yarn init -y
yarn add -D husky commitizen lint-staged
yarn commitizen init cz-conventional-changelog --yarn --dev --exact
yarn husky install
yarn husky add .husky/prepare-commit-msg "exec < /dev/tty && node_modules/.bin/cz --hook || true"
yarn husky add .husky/pre-commit "php bin/phpunit"