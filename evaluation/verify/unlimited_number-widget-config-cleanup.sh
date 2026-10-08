#!/usr/bin/env bash
# MEDIUM (introspection) cleanup for unlimited_number.
# Restores baseline by deleting the planted `field_un_limit` integer field (which also
# removes its field config and the entity_form_display component). No other site state
# is touched. Safe to run repeatedly.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  if ($fs = FieldStorageConfig::loadByName("node", "field_un_limit")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed field_un_limit (baseline restored)"
