#!/usr/bin/env bash
# Introspection CLEANUP (serial M1): delete field_srl_known (drops the assistant table too).
# Only removes this module's own field_srl_* storage by name. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_srl_known")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_srl_known")){$fs->delete();}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_srl_known removed from node.article"
