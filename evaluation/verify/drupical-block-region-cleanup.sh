#!/usr/bin/env bash
# Introspection CLEANUP: remove the known Events Feed block instance created for the case.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($b = \Drupal::entityTypeManager()->getStorage("block")->load("eval_drupical_block")) { $b->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block eval_drupical_block removed"
