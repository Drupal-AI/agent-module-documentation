#!/usr/bin/env bash
# Execution RESET (also CLEANUP): remove field_pn_us so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_pn_us")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_pn_us")){$fs->delete();}
' >/dev/null 2>&1
echo "reset: field_pn_us removed from node.article"
