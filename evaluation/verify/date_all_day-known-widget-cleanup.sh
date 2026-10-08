#!/usr/bin/env bash
# Introspection CLEANUP: remove field_dad_known from Article, dropping its form/view display
# components and all date_all_day settings. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_dad_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_dad_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_dad_known removed from node.article"
