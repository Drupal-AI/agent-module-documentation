#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_spn_known")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_spn_known")){$fs->delete();}
' >/dev/null 2>&1
echo "cleanup: field_spn_known removed"
