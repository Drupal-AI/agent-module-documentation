#!/usr/bin/env bash
# Introspection CLEANUP: remove the known block group created for the derived-block case.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("block_group_content")->load("eval_promo_sidebar")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block_group_content eval_promo_sidebar removed"
