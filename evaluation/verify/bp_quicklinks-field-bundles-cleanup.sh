#!/usr/bin/env bash
# Introspection CLEANUP for bp_quicklinks: remove field_bpquick_slot from node.article.
# Leaves the shipped bp_quicklinks / bp_simple paragraph types untouched. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_bpquick_slot")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_bpquick_slot")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_bpquick_slot removed from node.article"
