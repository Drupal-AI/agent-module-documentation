#!/usr/bin/env bash
# Introspection CLEANUP: remove field_dim_known_len (storage + config) from Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_dim_known_len")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_dim_known_len")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_dim_known_len removed from node.article"
