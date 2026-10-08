#!/usr/bin/env bash
# Introspection CLEANUP: remove field_ff_ref (drops its view-display component). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_ff_ref")) { try{$fc->delete();}catch(\Throwable $e){} }
  if ($fs=FieldStorageConfig::loadByName("node","field_ff_ref")) { try{$fs->delete();}catch(\Throwable $e){} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_ff_ref removed from node.article"
