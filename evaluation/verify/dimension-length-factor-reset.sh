#!/usr/bin/env bash
# Execution RESET: ensure field_dim_length does NOT exist on Article, so verify FAILS until the
# agent creates it with length.factor=10. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_dim_length")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_dim_length")) { $fs->delete(); }
' >/dev/null 2>&1
echo "reset: field_dim_length absent on node.article"
