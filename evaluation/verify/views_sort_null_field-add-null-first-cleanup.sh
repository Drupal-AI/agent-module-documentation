#!/usr/bin/env bash
# Execution CLEANUP: delete view vsnf_taskb (config factory) and field_vsnf_taskb. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  \Drupal::configFactory()->getEditable("views.view.vsnf_taskb")->delete();
  if ($fc = FieldConfig::loadByName("node","article","field_vsnf_taskb")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_vsnf_taskb")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: removed view vsnf_taskb and field_vsnf_taskb"
