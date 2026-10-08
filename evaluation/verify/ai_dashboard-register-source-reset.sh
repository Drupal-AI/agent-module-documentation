#!/usr/bin/env bash
# Execution RESET for "re-register the ai_dashboard_recommended Project Browser source".
# Removes the ai_dashboard_recommended entry from project_browser.admin_settings enabled_sources
# so verify FAILS until the agent re-adds it (mimicking ai_dashboard's hook_install).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("project_browser.admin_settings");
  $s = $c->get("enabled_sources") ?: [];
  unset($s["ai_dashboard_recommended"]);
  $c->set("enabled_sources", $s)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: ai_dashboard_recommended source removed from enabled_sources"
