#!/usr/bin/env bash
# Execution CLEANUP: remove field_fsui_task + field_fsui_trigger. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_fsui_task","field_fsui_trigger"] as $f) {
    if ($fc = FieldConfig::loadByName("node","article",$f)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node",$f)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fsui_task + field_fsui_trigger removed"
