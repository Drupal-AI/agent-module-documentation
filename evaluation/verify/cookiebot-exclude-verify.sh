#!/usr/bin/env bash
# Execution VERIFY: PASS when admin theme is excluded AND exclude_paths contains /blog/*.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("cookiebot.settings");
  $admin = (bool) $c->get("exclude_admin_theme");
  $paths = (string) $c->get("exclude_paths");
  $ok = $admin && (strpos($paths, "/blog/*") !== FALSE);
  print ($ok ? "PASS" : "FAIL") . " exclude_admin_theme=" . var_export($admin, TRUE) . " paths=" . var_export($paths, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
