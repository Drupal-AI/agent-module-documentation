#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_sir_known")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_sir_known")){$fs->delete();}
' >/dev/null 2>&1
echo "cleanup: field_sir_known removed"
