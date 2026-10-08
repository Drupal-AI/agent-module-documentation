#!/usr/bin/env bash
# Reset the `eval_ld_simple` lang_dropdown execution eval to a clean baseline between runs:
# delete the eval_ld_simple block config entity (if present) and rebuild caches.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $b = \Drupal::entityTypeManager()->getStorage("block")->load("eval_ld_simple");
  if ($b) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block eval_ld_simple removed"
