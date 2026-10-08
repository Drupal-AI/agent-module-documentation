#!/usr/bin/env bash
# Introspection SETUP: ensure the Total Control Page Manager dashboard page is present and enabled
# (its shipped state) so an agent can read back its path/status from live config. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $p = \Drupal::configFactory()->getEditable("page_manager.page.total_control_dashboard");
  if (!$p->isNew()) { $p->set("status", TRUE)->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: total_control dashboard page enabled"
