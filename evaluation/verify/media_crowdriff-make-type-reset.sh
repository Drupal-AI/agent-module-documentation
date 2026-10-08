#!/usr/bin/env bash
# Execution RESET: ensure media type mc_task_type does NOT exist, so verify FAILS until the
# agent creates a Crowdriff media type. Also leaves the site clean when run at the end.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fc = FieldConfig::loadByName("media","mc_task_type","field_media_media_crowdriff")) { $fc->delete(); }
  if ($t = MediaType::load("mc_task_type")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media","field_media_media_crowdriff")) {
    if (count($fs->getBundles()) === 0) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mc_task_type absent"
