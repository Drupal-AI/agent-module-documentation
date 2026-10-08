#!/usr/bin/env bash
# Introspection CLEANUP: remove the known node.article field_year_intro yearonly field
# (config + storage), restoring baseline (it does not ship by default). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($fc = \Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_year_intro")) { $fc->delete(); }
  if ($fs = \Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_year_intro")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article field_year_intro removed"
