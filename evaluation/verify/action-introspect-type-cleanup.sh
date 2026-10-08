#!/usr/bin/env bash
# Introspection CLEANUP: remove the known comment keyword action.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("action")->load("eval_comment_action")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: action eval_comment_action removed"
