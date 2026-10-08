#!/usr/bin/env bash
# Execution RESET (tzfield create): ensure field_tz_new is ABSENT from Article, so verify FAILS
# until the agent creates the time zone field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_tz_new")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_tz_new")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_tz_new absent from Article"
