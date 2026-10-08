#!/usr/bin/env bash
# Introspection CLEANUP: remove the three fields created by the matching setup
# (field_prepop_a/b/c) and their storages. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_prepop_a", "field_prepop_b", "field_prepop_c"] as $fn) {
    if ($fc = FieldConfig::loadByName("node", "article", $fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_prepop_a, field_prepop_b, field_prepop_c removed from node.article"
exit 0
