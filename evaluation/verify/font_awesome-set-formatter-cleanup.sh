#!/usr/bin/env bash
# Execution CLEANUP: delete only the field_fa_task field created for this case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_fa_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_fa_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fa_task removed"
