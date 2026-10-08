#!/usr/bin/env bash
# Execution CLEANUP: remove field_vrf_task. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_vrf_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_vrf_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_vrf_task removed"
