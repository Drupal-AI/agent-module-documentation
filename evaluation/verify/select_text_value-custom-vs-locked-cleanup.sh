#!/usr/bin/env bash
# Introspection CLEANUP: remove field_stv_open/field_stv_locked storages and stv_content type.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (["field_stv_open", "field_stv_locked"] as $fn) {
    if ($fs = FieldStorageConfig::loadByName("node", $fn)) { $fs->delete(); }
  }
  if ($t = NodeType::load("stv_content")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_stv_open, field_stv_locked and stv_content removed"
