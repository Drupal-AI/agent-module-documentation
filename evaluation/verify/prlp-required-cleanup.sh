#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default password_required=true. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("prlp.settings")->set("password_required", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: password_required restored to true"
