#!/usr/bin/env bash
# Introspection CLEANUP: remove fcc_m2 field_fcc_m2. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "fcc_m2", "field_fcc_m2")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fcc_m2")) { $fs->delete(); }
  if ($nt = NodeType::load("fcc_m2")) { $nt->delete(); }
' >/dev/null 2>&1
echo "cleanup: node.fcc_m2 field field_fcc_m2 removed"
