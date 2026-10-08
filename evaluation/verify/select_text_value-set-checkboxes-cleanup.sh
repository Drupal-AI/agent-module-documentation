#!/usr/bin/env bash
# Execution CLEANUP: remove field_stv_multi storage and stv_content type.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fs = FieldStorageConfig::loadByName("node", "field_stv_multi")) { $fs->delete(); }
  if ($t = NodeType::load("stv_content")) { $t->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_stv_multi and stv_content removed"
