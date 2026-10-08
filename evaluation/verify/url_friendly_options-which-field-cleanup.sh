#!/usr/bin/env bash
# Introspection CLEANUP: remove field_ufo_ok and field_ufo_bad. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ufo_ok", "field_ufo_bad"] as $name) {
    if ($fc = FieldConfig::loadByName("node", "article", $name)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $name)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ufo_ok and field_ufo_bad removed"
