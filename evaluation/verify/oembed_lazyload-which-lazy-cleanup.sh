#!/usr/bin/env bash
# Introspection CLEANUP: remove field_oel_lazy and field_oel_plain. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_oel_lazy","field_oel_plain"] as $fn) {
    if ($fc=FieldConfig::loadByName("node","article",$fn)) { $fc->delete(); }
    if ($fs=FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_oel_lazy and field_oel_plain removed"
