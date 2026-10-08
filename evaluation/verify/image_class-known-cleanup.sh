#!/usr/bin/env bash
# Introspection CLEANUP: remove field_ic_known (drops its display component + image_class setting).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_ic_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_ic_known")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ic_known removed from node.article"
