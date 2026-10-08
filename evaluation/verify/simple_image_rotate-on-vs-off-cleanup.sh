#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  foreach (["field_sir_on","field_sir_off"] as $name) {
    if ($fc=FieldConfig::loadByName("node","article",$name)){$fc->delete();}
    if ($fs=FieldStorageConfig::loadByName("node",$name)){$fs->delete();}
  }
' >/dev/null 2>&1
echo "cleanup: field_sir_on and field_sir_off removed"
