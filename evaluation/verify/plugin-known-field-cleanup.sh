#!/usr/bin/env bash
# Introspection CLEANUP: remove the plugin:condition field created by the matching setup.
# Restores baseline (Article has no field_plugin_known). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_plugin_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_plugin_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_plugin_known removed from node.article"
