#!/usr/bin/env bash
# Introspection CLEANUP: restore shipped default use_cdn=false. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("datatables.settings")->set("use_cdn", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: datatables.settings use_cdn=false"
