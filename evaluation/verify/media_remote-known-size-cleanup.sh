#!/usr/bin/env bash
# Introspection CLEANUP: delete the mr_size media type, its field instance, its default display,
# and the field_mr_size storage if unused. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if ($d = EntityViewDisplay::load("media.mr_size.default")) { $d->delete(); }
  if ($fc = FieldConfig::loadByName("media", "mr_size", "field_mr_size")) { $fc->delete(); }
  if ($t = MediaType::load("mr_size")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_mr_size")) {
    if (count($fs->getBundles()) === 0) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type mr_size and field_mr_size removed"
