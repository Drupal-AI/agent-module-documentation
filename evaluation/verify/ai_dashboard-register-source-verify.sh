#!/usr/bin/env bash
# Live-state verification for "re-register the ai_dashboard_recommended Project Browser source".
# PASS if project_browser.admin_settings.enabled_sources.ai_dashboard_recommended exists with
# the canonical recipes URI and an integer ttl >= 1. Prints PASS/FAIL, exits 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::config("project_browser.admin_settings")->get("enabled_sources") ?: [];
  $e = $s["ai_dashboard_recommended"] ?? NULL;
  $uri_ok = is_array($e) && isset($e["uri"])
    && strpos($e["uri"], "ai_dashboard_recommended_recipes.yml") !== FALSE
    && strpos($e["uri"], "git.drupalcode.org") !== FALSE;
  $ttl_ok = is_array($e) && isset($e["ttl"]) && is_int($e["ttl"] + 0) && (int) $e["ttl"] >= 1;
  $ok = $uri_ok && $ttl_ok;
  print ($ok ? "PASS" : "FAIL") . " uri=" . ($uri_ok?1:0) . " ttl=" . ($ttl_ok?1:0)
    . " val=" . json_encode($e) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
