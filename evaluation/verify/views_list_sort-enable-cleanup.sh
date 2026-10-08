#!/usr/bin/env bash
# Execution CLEANUP: remove vls_task_view and field_vls_task. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\views\Entity\View;
  if ($v = View::load("vls_task_view")) { $v->delete(); }
  if ($fc = FieldConfig::loadByName("node", "article", "field_vls_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_vls_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: vls_task_view and field_vls_task removed"
