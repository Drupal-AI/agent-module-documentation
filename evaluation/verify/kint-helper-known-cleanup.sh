#!/usr/bin/env bash
# Introspection CLEANUP: delete the custom kint.helper.kdump config (keeps default d/s). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("kint.helper.kdump")->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: kint.helper.kdump removed"
