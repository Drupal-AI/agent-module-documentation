#!/usr/bin/env bash
# Introspection CLEANUP: remove both datetime fields created by the matching setup
# (field_dhs_on, field_dhs_off), dropping their form-display components and settings.
# Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_dhs_on", "field_dhs_off"] as $fn) {
    if ($fc = FieldConfig::loadByName("node", "article", $fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_dhs_on and field_dhs_off removed from node.article"
