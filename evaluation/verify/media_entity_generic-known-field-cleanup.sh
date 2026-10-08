#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($t = MediaType::load("meg_field")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_meg_code")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: meg_field + field_meg_code removed"
