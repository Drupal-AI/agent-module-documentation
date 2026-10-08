#!/usr/bin/env bash
# Execution VERIFY: PASS when paths has an INCLUDE for the /reports section AND a ~-prefixed
# EXCLUDE covering /reports/public. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $paths = \Drupal::config("anonymous_login.settings")->get("paths") ?? [];
  $inc = FALSE; $exc = FALSE;
  foreach ($paths as $p) {
    $p = trim($p);
    if (str_starts_with($p, "~")) {
      $t = ltrim(substr($p, 1), "/");
      if (str_starts_with($t, "reports/public")) { $exc = TRUE; }
    }
    else {
      $t = ltrim($p, "/");
      if (str_starts_with($t, "reports")) { $inc = TRUE; }
    }
  }
  $ok = $inc && $exc;
  print ($ok ? "PASS" : "FAIL")." include=".var_export($inc,true)." exclude=".var_export($exc,true)." paths=".json_encode($paths)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
