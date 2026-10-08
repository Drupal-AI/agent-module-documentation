#!/usr/bin/env bash
# Introspection CLEANUP: delete rhs_nf entities + type. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("storage");
  $ids = $s->getQuery()->accessCheck(FALSE)->condition("type","rhs_nf")->execute();
  foreach ($ids as $id) { $s->load($id)->delete(); }
  try { if ($t = \Drupal\storage\Entity\StorageType::load("rhs_nf")) { $t->delete(); } } catch (\Throwable $e) {}
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: rhs_nf entities + type removed"
