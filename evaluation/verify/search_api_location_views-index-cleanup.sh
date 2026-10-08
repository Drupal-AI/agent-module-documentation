#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\search_api\Entity\Index;
  if ($i=Index::load("salv_index")) $i->delete();
  if ($fc=FieldConfig::loadByName("node","article","field_salv_geo")) $fc->delete();
  if ($fs=FieldStorageConfig::loadByName("node","field_salv_geo")) $fs->delete();
  \Drupal::service("views.views_data")->clear();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: salv_index and field_salv_geo removed"
