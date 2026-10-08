#!/usr/bin/env bash
# Introspection CLEANUP: remove the known keyword action created for the introspection case.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("action")->load("eval_kw_action")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: action eval_kw_action removed"
