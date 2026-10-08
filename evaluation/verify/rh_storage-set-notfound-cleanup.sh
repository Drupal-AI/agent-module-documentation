#!/usr/bin/env bash
# Execution CLEANUP: delete rhs_hide entities + type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","rhs_hide")->execute();
  foreach ($ids as $id) { $s->load($id)->delete(); }
  try { if ($t = \Drupal\storage\Entity\StorageType::load("rhs_hide")) { $t->delete(); } } catch (\Throwable $e) {}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rhs_hide entities + type removed"
