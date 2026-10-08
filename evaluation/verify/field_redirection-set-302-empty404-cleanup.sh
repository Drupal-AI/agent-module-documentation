#!/usr/bin/env bash
# Execution CLEANUP: remove field_fr_temp. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fr_temp")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fr_temp")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_fr_temp removed from node.article"
