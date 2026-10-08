#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_ic_on","field_ic_off"] as $fn) {
    if ($fc = FieldConfig::loadByName("node","article",$fn)) { $fc->delete(); }
    if ($fs = FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ic_on/field_ic_off removed"
