#!/usr/bin/env bash
# Introspection CLEANUP: remove the datetime field created by the matching setup, which also
# drops its form-display component and the datetimehideseconds third-party setting. Restores
# baseline (Article has no field_dhs_known). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_dhs_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_dhs_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_dhs_known removed from node.article"
