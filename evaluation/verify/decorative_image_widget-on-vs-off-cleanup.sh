#!/usr/bin/env bash
# Introspection CLEANUP: remove field_diw_on and field_diw_off. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_diw_on","field_diw_off"] as $fn) {
    if ($fc=FieldConfig::loadByName("node","article",$fn)) { try{$fc->delete();}catch(\Throwable $e){} }
    if ($fs=FieldStorageConfig::loadByName("node",$fn)) { try{$fs->delete();}catch(\Throwable $e){} }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_diw_on and field_diw_off removed"
