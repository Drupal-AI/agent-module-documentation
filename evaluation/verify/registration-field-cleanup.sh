#!/usr/bin/env bash
# Execution CLEANUP: remove field_reg_event from node.article (drops instance + storage).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_reg_event")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_reg_event")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: node.article field_reg_event removed"
