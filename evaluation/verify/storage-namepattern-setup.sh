#!/usr/bin/env bash
# Introspection SETUP: create a storage type storage_known with a known name pattern so the
# agent can read the storage_type config back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\storage\Entity\StorageType;
  if (!StorageType::load("storage_known")) {
    StorageType::create(["id"=>"storage_known","label"=>"Storage Known","name_pattern"=>"[storage:string-representation]","status"=>TRUE,"new_revision"=>TRUE,"has_canonical"=>FALSE])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: storage.storage_type.storage_known name_pattern=[storage:string-representation]"
