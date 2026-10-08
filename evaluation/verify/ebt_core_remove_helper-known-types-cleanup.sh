#!/usr/bin/env bash
# Introspection CLEANUP: remove the ebt_rhprobe block content type (and any of its blocks). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $bs = \Drupal::entityTypeManager()->getStorage("block_content");
  $ids = \Drupal::entityQuery("block_content")->accessCheck(FALSE)->condition("type","ebt_rhprobe")->execute();
  if ($ids) { $bs->delete($bs->loadMultiple($ids)); }
  if ($t = \Drupal::entityTypeManager()->getStorage("block_content_type")->load("ebt_rhprobe")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: ebt_rhprobe block content type removed"
