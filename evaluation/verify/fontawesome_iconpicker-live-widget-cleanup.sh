#!/usr/bin/env bash
# Introspection CLEANUP: remove field_faip_known (drops its own field storage only). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_faip_known")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_faip_known")) { $fs->delete(); }
' >/dev/null 2>&1
echo "cleanup: field_faip_known removed from node.article"
