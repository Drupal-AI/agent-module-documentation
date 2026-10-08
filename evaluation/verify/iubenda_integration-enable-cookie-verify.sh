#!/usr/bin/env bash
# Execution VERIFY: PASS when the Iubenda cookie solution is enabled AND the siteId is 555777.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("iubenda_integration.settings");
  $enabled = $c->get("cookie_solution_enable");
  $site = $c->get("siteId");
  $ok = (!empty($enabled) && (string) $site === "555777");
  print ($ok ? "PASS" : "FAIL") . " cookie_solution_enable=" . var_export($enabled, TRUE) . " siteId=" . var_export($site, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
