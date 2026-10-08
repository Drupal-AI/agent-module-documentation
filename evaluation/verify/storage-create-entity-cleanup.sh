#!/usr/bin/env bash
# Execution CLEANUP: delete all storage_item entities and the storage_item type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","storage_item")->execute();
  foreach ($ids as $id) { $s->load($id)->delete(); }
  try { if ($t = \Drupal\storage\Entity\StorageType::load("storage_item")) { $t->delete(); } } catch (\Throwable $e) {}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: storage_item entities + type removed"
