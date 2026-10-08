#!/usr/bin/env bash
# Reset the "add a computed field to Basic page" execution task to a clean slate between runs.
# Removes what the task creates: the node.page.computed_eval_pagerefs computed_field entity.
# The Basic page type ships with standard installs, so no precondition create is needed.
# Rebuilds caches. Safe to run repeatedly (delete guarded). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("computed_field")->load("node.page.computed_eval_pagerefs")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.page.computed_eval_pagerefs removed"
