#!/usr/bin/env bash
# Reset the `eval_block_tabs` Quick Tabs execution eval to a clean baseline between
# runs: delete the eval_block_tabs quicktabs_instance (if present) and rebuild
# caches. Modelled on quicktabs-reset.sh. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $qt = \Drupal::entityTypeManager()->getStorage("quicktabs_instance")->load("eval_block_tabs");
  if ($qt) { $qt->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: quicktabs_instance eval_block_tabs removed"
