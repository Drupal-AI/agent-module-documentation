#!/usr/bin/env bash
# Introspection CLEANUP: leave the dashboard page enabled (shipped state). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $p = \Drupal::configFactory()->getEditable("page_manager.page.total_control_dashboard");
  if (!$p->isNew()) { $p->set("status", TRUE)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: total_control dashboard page enabled"
