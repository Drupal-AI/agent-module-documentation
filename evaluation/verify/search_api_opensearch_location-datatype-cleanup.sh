#!/usr/bin/env bash
# Cleanup: remove the index and the geofield created by setup (restores baseline). Only touches
# our own saol_* / field_saol_geo artifacts.
set -uo pipefail
cd /var/www/html
drush php:eval 'use Drupal\search_api\Entity\Index; if($i=Index::load("saol_med_idx")){$i->delete();}' >/dev/null 2>&1
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_saol_geo")) { $fc->delete(); }
  if ($fs=FieldStorageConfig::loadByName("node","field_saol_geo")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: saol_med_idx + field_saol_geo removed"
