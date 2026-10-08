#!/usr/bin/env bash
# Introspection CLEANUP: remove field_co_created from node.article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_co_created")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_co_created")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_co_created removed from node.article"
