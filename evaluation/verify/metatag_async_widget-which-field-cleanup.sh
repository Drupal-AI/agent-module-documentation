#!/usr/bin/env bash
# Introspection CLEANUP: remove field_maw_async and field_maw_std from Article. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  use Drupal\field\Entity\FieldStorageConfig;
  foreach (["field_maw_async","field_maw_std"] as $fn) {
    if ($fc=FieldConfig::loadByName("node","article",$fn)) { $fc->delete(); }
    if ($fs=FieldStorageConfig::loadByName("node",$fn)) { $fs->delete(); }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_maw_async, field_maw_std removed"
