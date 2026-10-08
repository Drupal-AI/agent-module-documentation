#!/usr/bin/env bash
# Introspection CLEANUP: remove field_eabrf_fb from Article (restores baseline).
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc = FieldConfig::loadByName("node","article","field_eabrf_fb")) { $fc->delete(); }
  if ($fs = FieldStorageConfig::loadByName("node","field_eabrf_fb")) { $fs->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_eabrf_fb removed from node.article"
