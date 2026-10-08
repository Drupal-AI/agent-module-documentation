#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($t = MediaType::load("meg_task2")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_meg_ref")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: meg_task2 + field_meg_ref removed"
