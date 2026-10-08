#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default password_required=true. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("prlp.settings")->set("password_required", TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: password_required restored to true"
