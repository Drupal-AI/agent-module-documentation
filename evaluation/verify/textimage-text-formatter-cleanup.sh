#!/usr/bin/env bash
# Execution CLEANUP: remove field_ti_head (drops its display component too). Restores baseline.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ti_head")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ti_head")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ti_head removed from node.article"
