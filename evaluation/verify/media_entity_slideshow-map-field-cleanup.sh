#!/usr/bin/env bash
# Execution CLEANUP: remove media type mes_fixed and field_mes_slides.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("media","mes_fixed","field_mes_slides")) { $fc->delete(); }
  if ($t = MediaType::load("mes_fixed")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media","field_mes_slides")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type mes_fixed removed"
