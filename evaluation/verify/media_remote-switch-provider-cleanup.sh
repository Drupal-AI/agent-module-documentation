#!/usr/bin/env bash
# Execution CLEANUP: delete the mr_switch media type, its field instance, default display and the
# field_mr_switch storage if unused. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\Core\Entity\Entity\EntityViewDisplay;
  if ($d = EntityViewDisplay::load("media.mr_switch.default")) { $d->delete(); }
  if ($fc = FieldConfig::loadByName("media", "mr_switch", "field_mr_switch")) { $fc->delete(); }
  if ($t = MediaType::load("mr_switch")) { $t->delete(); }
  if ($fs = FieldStorageConfig::loadByName("media", "field_mr_switch")) {
    if (count($fs->getBundles()) === 0) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: media type mr_switch and field_mr_switch removed"
