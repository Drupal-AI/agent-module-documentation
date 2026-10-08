#!/usr/bin/env bash
# Introspection SETUP: set known batch_size + md5_checksum in ip2country.settings.
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip2country.settings");$c->set("batch_size",500)->set("md5_checksum",TRUE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ip2country.settings batch_size=500 md5_checksum=true"
