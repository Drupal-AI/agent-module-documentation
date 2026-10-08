#!/usr/bin/env bash
# Execution CLEANUP: delete field_atc_task (removes its display component + addtocal settings).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_atc_task")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_atc_task")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_atc_task removed from node.article"
