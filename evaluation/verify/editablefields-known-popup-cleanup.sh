#!/usr/bin/env bash
# Introspection CLEANUP: remove field_ef_note from Article. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ef_note")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ef_note")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ef_note removed from node.article"
