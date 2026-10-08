#!/usr/bin/env bash
# Execution RESET: ensure the submodule is enabled and Article has NO field_eref_task, so
# verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:install entity_reference_entity_modify -y >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_eref_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_eref_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_eref_task absent from node.article"
