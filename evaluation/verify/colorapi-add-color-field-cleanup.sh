#!/usr/bin/env bash
# Execution CLEANUP: delete field_cai_color. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_cai_color")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_cai_color")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_cai_color removed from node.article"
