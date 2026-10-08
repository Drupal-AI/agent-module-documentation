#!/usr/bin/env bash
# Introspection CLEANUP: remove field_idf_promo. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_idf_promo")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_idf_promo")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_idf_promo removed from node.article"
