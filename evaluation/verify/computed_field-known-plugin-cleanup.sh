#!/usr/bin/env bash
# MEDIUM introspection cleanup: remove the known computed field created for the
# known-plugin case, restoring baseline. Safe to run repeatedly.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("computed_field")->load("node.article.computed_eval_backlinks")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: node.article.computed_eval_backlinks removed"
