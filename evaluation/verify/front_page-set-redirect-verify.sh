#!/usr/bin/env bash
# Execution VERIFY: PASS when the override is enabled AND the anonymous role redirects to
# /user/login (enabled + path). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("front_page.settings");
  $enabled = $c->get("enabled");
  $r = $c->get("roles.anonymous") ?: [];
  $ok = ($enabled === TRUE && !empty($r["enabled"]) && ($r["path"] ?? "") === "/user/login");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($enabled, TRUE) . " anon_enabled=" . var_export($r["enabled"] ?? NULL, TRUE) . " anon_path=" . var_export($r["path"] ?? NULL, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
