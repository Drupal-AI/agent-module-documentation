#!/usr/bin/env bash
# Execution RESET: delete View vrss_fmt_task and disable views_rss_format, so verify FAILS
# until the agent both re-enables the module and builds the view. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $storage->load("vrss_fmt_task")) { $v->delete(); }
' >/dev/null 2>&1
drush pmu views_rss_format -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vrss_fmt_task absent, views_rss_format disabled"
