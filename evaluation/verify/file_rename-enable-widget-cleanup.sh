#!/usr/bin/env bash
# Execution CLEANUP: remove field_fr_task from Article and restore the global flag default (1).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fr_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fr_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush config:set file_rename.settings always_show_widget_link 1 -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fr_task removed; always_show_widget_link restored to 1"
