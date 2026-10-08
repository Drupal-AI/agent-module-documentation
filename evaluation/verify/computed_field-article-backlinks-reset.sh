#!/usr/bin/env bash
# Reset the "add a computed field to Article" execution task to a clean slate between runs.
# Removes what the task creates: the node.article.computed_eval_referrers computed_field entity.
# Article ships with standard installs, so no precondition create is needed. Then rebuilds
# caches. Safe to run repeatedly (delete is guarded). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($e = \Drupal::entityTypeManager()->getStorage("computed_field")->load("node.article.computed_eval_referrers")) { $e->delete(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.computed_eval_referrers removed"
