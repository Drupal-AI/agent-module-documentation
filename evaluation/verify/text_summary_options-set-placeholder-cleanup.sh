#!/usr/bin/env bash
# Execution CLEANUP: remove the namespaced field field_tso_ph from Article (drops its display
# component + module setting), leaving the site clean after the execution case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_tso_ph")) { try{$fc->delete();}catch(\Throwable $e){} }
  if ($fs=FieldStorageConfig::loadByName("node","field_tso_ph")) { try{$fs->delete();}catch(\Throwable $e){} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_tso_ph removed from node.article"
