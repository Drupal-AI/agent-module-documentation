#!/usr/bin/env bash
# Introspection CLEANUP: remove field_jqmc_fmt. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node", "article", "field_jqmc_fmt")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node", "field_jqmc_fmt")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_jqmc_fmt removed"
