#!/usr/bin/env bash
# Introspection CLEANUP for entity_browser_block "known browser".
# Removes the placed block and the eval_browser created by the matching setup, restoring the
# baseline (no Entity Browser Block placed, no eval_browser). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal\block\Entity\Block::load("ebb_eval_derived")?->delete();
  \Drupal::entityTypeManager()->getStorage("entity_browser")->load("eval_browser")?->delete();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: removed block ebb_eval_derived and eval_browser"
