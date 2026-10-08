#!/usr/bin/env bash
# Introspection CLEANUP: remove field_erv_sel and field_erv_btn. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_erv_sel","field_erv_btn"] as $fn) {
    if ($fc=FieldConfig::loadByName("node","article",$fn)) { $fc->delete(); }
    if ($fs=FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_erv_sel and field_erv_btn removed"
