#!/usr/bin/env bash
# Execution VERIFY: PASS when anonymous_login.settings.paths has an INCLUDE (no leading ~)
# matching the /portal section. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $paths = \Drupal::config("anonymous_login.settings")->get("paths") ?? [];
  $ok = FALSE;
  foreach ($paths as $p) {
    $t = ltrim(trim($p), "/");
    if (str_starts_with(trim($p), "~")) { continue; }
    if (str_starts_with($t, "portal")) { $ok = TRUE; }
  }
  print ($ok ? "PASS" : "FAIL")." paths=".json_encode($paths)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
