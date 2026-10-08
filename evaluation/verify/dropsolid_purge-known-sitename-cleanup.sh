#!/usr/bin/env bash
# Introspection CLEANUP: delete the dropsolid_purge.config object (restores unconfigured baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("dropsolid_purge.config")->delete();' >/dev/null 2>&1
echo "cleanup: dropsolid_purge.config removed"
