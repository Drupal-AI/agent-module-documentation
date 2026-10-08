#!/usr/bin/env bash
# Introspection CLEANUP: remove the known block group created for the label case.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("block_group_content")->load("eval_footer_group")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block_group_content eval_footer_group removed"
