#!/usr/bin/env bash
# Introspection CLEANUP: remove field_name_ctm and the name_ctm content type. Restores baseline.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "name_ctm", "field_name_ctm")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_name_ctm")) { $fs->delete(); }
  if ($nt = NodeType::load("name_ctm")) { $nt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: name_ctm + field_name_ctm removed"
