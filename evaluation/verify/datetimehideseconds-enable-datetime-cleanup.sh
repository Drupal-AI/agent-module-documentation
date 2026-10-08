#!/usr/bin/env bash
# Execution CLEANUP: remove the datetime field field_dhs_task created by the enable-datetime
# reset, dropping its form-display component and any datetimehideseconds setting. Restores
# baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_dhs_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_dhs_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_dhs_task removed from node.article"
