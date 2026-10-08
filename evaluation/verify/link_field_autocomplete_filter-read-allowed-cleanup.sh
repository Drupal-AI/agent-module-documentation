#!/usr/bin/env bash
# Introspection CLEANUP: remove lfaf_m1 and its link field.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "lfaf_m1", "field_lfaf_m1")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_lfaf_m1")) { $fs->delete(); }
  if ($nt = NodeType::load("lfaf_m1")) { $nt->delete(); }
' >/dev/null 2>&1
echo "cleanup: node.lfaf_m1 field field_lfaf_m1 removed"
