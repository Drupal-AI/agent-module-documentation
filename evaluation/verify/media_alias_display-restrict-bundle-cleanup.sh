#!/usr/bin/env bash
# Execution CLEANUP: restore shipped default media_bundles={} (all bundles). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("media_alias_display.settings")->set("media_bundles", [])->save();' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media_bundles restored to {}"
