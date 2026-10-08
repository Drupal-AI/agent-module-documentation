#!/usr/bin/env bash
# Execution RESET: ensure NO fixed_block_content entity fbc_task exists, so verify FAILS until the
# agent creates one targeting the "basic" custom block bundle. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("fixed_block_content");
  if ($e = $s->load("fbc_task")) {
    if ($bc = $e->getBlockContent(FALSE)) { $bc->delete(); }
    $e->delete();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: fbc_task absent"
