#!/usr/bin/env bash
# Execution RESET (also CLEANUP): remove field_spn_task so verify FAILS on empty state. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_spn_task")){$fc->delete();}
  if ($fs=FieldStorageConfig::loadByName("node","field_spn_task")){$fs->delete();}
' >/dev/null 2>&1
echo "reset: field_spn_task removed"
