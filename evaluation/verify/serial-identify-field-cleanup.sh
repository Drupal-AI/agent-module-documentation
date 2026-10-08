#!/usr/bin/env bash
# Introspection CLEANUP (serial M2): delete field_srl_auto and field_srl_plain from Article.
# Only removes this module's own field_srl_* storages by name. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  foreach (["field_srl_auto","field_srl_plain"] as $fn) {
    if ($fc=FieldConfig::loadByName("node","article",$fn)){$fc->delete();}
    if ($fs=FieldStorageConfig::loadByName("node",$fn)){$fs->delete();}
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_srl_auto and field_srl_plain removed"
