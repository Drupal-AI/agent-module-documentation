#!/usr/bin/env bash
# Introspection CLEANUP: restore the ai_dashboard_recommended source TTL to the hook_install
# baseline (1). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("project_browser.admin_settings");
  $s = $c->get("enabled_sources") ?: [];
  if (isset($s["ai_dashboard_recommended"])) {
    $s["ai_dashboard_recommended"]["ttl"] = 1;
    $c->set("enabled_sources", $s)->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: ai_dashboard_recommended ttl restored to 1"
