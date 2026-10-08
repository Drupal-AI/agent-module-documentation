#!/usr/bin/env bash
# Removes the namespaced Search API infra + field created by the submodule eval setups.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\search_api\Entity\Index;
  use Drupal\search_api\Entity\Server;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if ($i=Index::load("satmn_index")) { try{$i->delete();}catch(\Throwable $e){} }
  if ($s=Server::load("satmn_server")) { try{$s->delete();}catch(\Throwable $e){} }
  if ($fc=FieldConfig::loadByName("node","article","field_satmn_cat")) { try{$fc->delete();}catch(\Throwable $e){} }
  if ($fs=FieldStorageConfig::loadByName("node","field_satmn_cat")) { try{$fs->delete();}catch(\Throwable $e){} }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "teardown: satmn_index, satmn_server and field_satmn_cat removed"
