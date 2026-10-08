#!/usr/bin/env bash
# Execution CLEANUP: delete the storage_task storage type (and any of its entities). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","storage_task")->execute();
  foreach ($ids as $id) { $s->load($id)->delete(); }
  try { if ($t = \Drupal\storage\Entity\StorageType::load("storage_task")) { $t->delete(); } } catch (\Throwable $e) {}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: storage type storage_task (and its entities) removed"
