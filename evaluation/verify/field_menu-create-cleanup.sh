#!/usr/bin/env bash
# Execution CLEANUP (field_menu): remove field_fmenu_task from Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fmenu_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fmenu_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fmenu_task removed from node.article"
