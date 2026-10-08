#!/usr/bin/env bash
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("user", "user", "field_sfa_new")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("user", "field_sfa_new")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_sfa_new removed"
