#!/usr/bin/env bash
# Introspection SETUP: create a storage type storage_canon with has_canonical enabled so the
# agent can discover which type allows direct viewing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\storage\Entity\StorageType;
  if (!StorageType::load("storage_canon")) {
    StorageType::create(["id"=>"storage_canon","label"=>"Storage Canon","has_canonical"=>TRUE,"status"=>TRUE,"new_revision"=>TRUE,"name_pattern"=>""])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: storage.storage_type.storage_canon has_canonical=true"
