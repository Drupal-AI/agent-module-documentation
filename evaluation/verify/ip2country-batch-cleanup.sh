#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '$c=\Drupal::configFactory()->getEditable("ip2country.settings");$c->set("batch_size",200)->set("md5_checksum",FALSE)->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ip2country.settings batch_size/md5_checksum restored to defaults"
