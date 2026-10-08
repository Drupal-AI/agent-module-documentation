#!/usr/bin/env bash
# Execution CLEANUP: remove lfaf_h1 and its link field.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "lfaf_h1", "field_lfaf_h1")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_lfaf_h1")) { $fs->delete(); }
  if ($nt = NodeType::load("lfaf_h1")) { $nt->delete(); }
' >/dev/null 2>&1
echo "cleanup: node.lfaf_h1 field field_lfaf_h1 removed"
