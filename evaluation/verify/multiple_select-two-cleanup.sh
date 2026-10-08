#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ms_a","field_ms_b"] as $fn) {
    if ($fc=FieldConfig::loadByName("node","article",$fn)) { $fc->delete(); }
    if ($fs=FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
  \Drupal::configFactory()->getEditable("multiple_select.settings")->set("table", NULL)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ms_a/field_ms_b removed, multiple_select.settings cleared"
