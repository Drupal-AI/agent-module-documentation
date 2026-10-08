#!/usr/bin/env bash
# CLEANUP: delete meg_known media type and its own field_meg_known storage. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  if ($t = MediaType::load("meg_known")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_meg_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: meg_known + field_meg_known removed"
