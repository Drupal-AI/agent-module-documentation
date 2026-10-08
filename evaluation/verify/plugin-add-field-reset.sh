#!/usr/bin/env bash
# Execution RESET: delete the field_plugin_task field from Article if present, so verify FAILS
# on empty state until the agent creates a "plugin" (plugin collection) field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_plugin_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_plugin_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_plugin_task removed from node.article"
