#!/usr/bin/env bash
# Execution CLEANUP: remove the field_rofw_task field created by the enable-task reset,
# dropping its form-display component. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_rofw_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_rofw_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_rofw_task removed from node.article"
