#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media","mes_gallery","field_mes_items")) { $fc->delete(); }
  if ($t = MediaType::load("mes_gallery")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media","field_mes_items")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type mes_gallery removed"
