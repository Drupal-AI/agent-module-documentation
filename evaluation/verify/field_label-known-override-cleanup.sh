#!/usr/bin/env bash
# CLEANUP: remove the field_fl_target field from Article (drops its display component and any
# field_label third-party settings). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_fl_target")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_fl_target")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_fl_target removed from node.article"
