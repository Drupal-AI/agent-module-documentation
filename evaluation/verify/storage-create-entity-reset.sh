#!/usr/bin/env bash
# Execution RESET: ensure the storage type 'storage_item' exists and has NO entities, so verify
# FAILS until the agent creates one. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\storage\Entity\StorageType;
  if (!StorageType::load("storage_item")) {
    StorageType::create(["id"=>"storage_item","label"=>"Storage Item","status"=>TRUE,"new_revision"=>TRUE,"name_pattern"=>"","has_canonical"=>FALSE])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","storage_item")->execute();
  foreach ($ids as $id) { $s->load($id)->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: storage type storage_item exists with no entities"
