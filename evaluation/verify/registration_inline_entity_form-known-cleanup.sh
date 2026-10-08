#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_reg_ief")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_reg_ief")){$fs->delete();}
' >/dev/null 2>&1
echo "cleanup: node.article field_reg_ief removed"
