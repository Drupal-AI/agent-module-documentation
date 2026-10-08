#!/usr/bin/env bash
# Introspection CLEANUP: remove field_tso_sum from Article (restores baseline). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($fc=FieldConfig::loadByName("node","article","field_tso_sum")) { try{$fc->delete();}catch(\Throwable $e){} }
  if ($fs=FieldStorageConfig::loadByName("node","field_tso_sum")) { try{$fs->delete();}catch(\Throwable $e){} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_tso_sum removed from node.article"
