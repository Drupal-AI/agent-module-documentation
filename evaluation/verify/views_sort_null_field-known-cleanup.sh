#!/usr/bin/env bash
# Introspection CLEANUP: delete view vsnf_known (via config factory) and field_vsnf_known. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  \Drupal::configFactory()->getEditable("views.view.vsnf_known")->delete();
  if ($fc = FieldConfig::loadByName("node","article","field_vsnf_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_vsnf_known")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: removed view vsnf_known and field_vsnf_known"
