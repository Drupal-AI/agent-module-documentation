#!/usr/bin/env bash
# Introspection SETUP: set the ai_dashboard_recommended Project Browser source cache TTL to a
# KNOWN distinctive value (4242) so an inspecting agent can read it back. Preserves the uri.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("project_browser.admin_settings");
  $s = $c->get("enabled_sources") ?: [];
  if (empty($s["ai_dashboard_recommended"]["uri"])) {
    $s["ai_dashboard_recommended"]["uri"] = "https://git.drupalcode.org/api/v4/projects/196945/repository/files/ai_dashboard_recommended_recipes.yml/raw?ref=HEAD";
  }
  $s["ai_dashboard_recommended"]["ttl"] = 4242;
  $c->set("enabled_sources", $s)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: ai_dashboard_recommended ttl = 4242"
