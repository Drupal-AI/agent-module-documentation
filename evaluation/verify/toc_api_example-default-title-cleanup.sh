#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped default toc_type title. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("toc_api.toc_type.default")->set("options.title", "Table of Contents")->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: default toc_type title restored to 'Table of Contents'"
