#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_ms_off")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_ms_off")) { $fs->delete(); }
  \Drupal::configFactory()->getEditable("multiple_select.settings")->set("table", NULL)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ms_off removed, multiple_select.settings cleared"
