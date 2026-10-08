#!/usr/bin/env bash
# Introspection CLEANUP: remove field_ecf_known from Article (which also drops its view-display
# component and the entity_class_formatter settings). Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_ecf_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_ecf_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ecf_known removed from node.article"
