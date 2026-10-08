#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($t = MediaType::load("meg_task")) { $t->delete(); }
  foreach (["field_meg_task", "field_media_meg_task"] as $fn) {
    if ($fs = FieldStorageConfig::loadByName("media", $fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: meg_task removed"
