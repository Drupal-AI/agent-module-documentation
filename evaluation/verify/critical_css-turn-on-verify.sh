#!/usr/bin/env bash
# hard VERIFY (critical_css): PASS when enabled === true AND dir_path === '/css/critical'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("critical_css.settings");
  $en = $c->get("enabled"); $dir = $c->get("dir_path");
  $ok = ($en === TRUE && $dir === "/css/critical");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . " dir_path=" . var_export($dir, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
