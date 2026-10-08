#!/usr/bin/env bash
# Execution CLEANUP: remove field_name_cth and the name_cth content type. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "name_cth", "field_name_cth")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_name_cth")) { $fs->delete(); }
  if ($nt = NodeType::load("name_cth")) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: name_cth + field_name_cth removed"
