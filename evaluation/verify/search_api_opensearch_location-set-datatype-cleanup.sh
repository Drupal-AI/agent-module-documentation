#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\search_api\Entity\Index; if($i=Index::load("saol_task")){$i->delete();}' >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_saol_geo")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_saol_geo")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: saol_task + field_saol_geo removed"
