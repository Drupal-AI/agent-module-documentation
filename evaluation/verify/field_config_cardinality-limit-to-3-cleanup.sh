#!/usr/bin/env bash
# Execution CLEANUP: remove fcc_h1 field_fcc_h1. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\node\Entity\NodeType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "fcc_h1", "field_fcc_h1")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fcc_h1")) { $fs->delete(); }
  if ($nt = NodeType::load("fcc_h1")) { $nt->delete(); }
' >/dev/null 2>&1
echo "cleanup: node.fcc_h1 field field_fcc_h1 removed"
