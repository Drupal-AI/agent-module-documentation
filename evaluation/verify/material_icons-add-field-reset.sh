#!/usr/bin/env bash
# Execution RESET: ensure field_mi_icon does NOT exist on Article, so verify FAILS until the
# agent creates it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_mi_icon")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_mi_icon")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_mi_icon absent on node.article"
