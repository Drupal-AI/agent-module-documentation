#!/usr/bin/env bash
# Introspection CLEANUP (entity_browser_vertical): remove field_ebv_on and field_ebv_off. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ebv_on", "field_ebv_off"] as $fn) {
    if ($fc = FieldConfig::loadByName("node", "article", $fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1 || true
echo "cleanup: field_ebv_on and field_ebv_off removed"
exit 0
