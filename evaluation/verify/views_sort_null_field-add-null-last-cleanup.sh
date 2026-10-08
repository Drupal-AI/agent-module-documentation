#!/usr/bin/env bash
# Execution CLEANUP: delete view vsnf_task (config factory) and field_vsnf_task. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  \Drupal::configFactory()->getEditable("views.view.vsnf_task")->delete();
  if ($fc = FieldConfig::loadByName("node","article","field_vsnf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_vsnf_task")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: removed view vsnf_task and field_vsnf_task"
