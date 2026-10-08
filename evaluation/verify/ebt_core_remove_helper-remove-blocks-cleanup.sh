#!/usr/bin/env bash
# Execution CLEANUP: remove any remaining ebt_rhtask blocks and the ebt_rhtask block type. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $bs = \Drupal::entityTypeManager()->getStorage("block_content");
  $ids = \Drupal::entityQuery("block_content")->accessCheck(FALSE)->condition("type","ebt_rhtask")->execute();
  if ($ids) { $bs->delete($bs->loadMultiple($ids)); }
  if ($t = \Drupal::entityTypeManager()->getStorage("block_content_type")->load("ebt_rhtask")) { $t->delete(); }
' >/dev/null 2>&1
echo "cleanup: ebt_rhtask type and blocks removed"
