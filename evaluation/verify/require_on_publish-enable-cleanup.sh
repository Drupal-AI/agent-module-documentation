#!/usr/bin/env bash
# Execution CLEANUP: remove field_rop_task from Article. Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_rop_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_rop_task")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_rop_task removed from node.article"
