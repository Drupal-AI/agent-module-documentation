#!/usr/bin/env bash
# Introspection CLEANUP: remove field_mlmm_setting. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_mlmm_setting")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_mlmm_setting")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_mlmm_setting removed from node.article"
