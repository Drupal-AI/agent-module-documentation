#!/usr/bin/env bash
# Introspection SETUP: set the locked Default redirect's status code to 301. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("content_translation_redirect.entity.default")->set("code", 301)->save();' >/dev/null 2>&1
echo "setup: Default redirect code=301"
