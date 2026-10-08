#!/usr/bin/env bash
# Introspection SETUP: enable the DataTables CDN option. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("datatables.settings")->set("use_cdn", TRUE)->save();' >/dev/null 2>&1
echo "setup: datatables.settings use_cdn=true"
