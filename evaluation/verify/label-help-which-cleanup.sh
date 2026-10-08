#!/usr/bin/env bash
# Introspection CLEANUP: delete field_lh_on and field_lh_off storages. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (["field_lh_on", "field_lh_off"] as $fn) {
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_lh_on and field_lh_off removed"
