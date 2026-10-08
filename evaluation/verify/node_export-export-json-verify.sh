#!/usr/bin/env bash
# Execution VERIFY: PASS when web/sites/default/files/ne_export_probe.json exists, is valid JSON,
# and contains the exported node titled 'NE Export Probe'.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $p = DRUPAL_ROOT . "/sites/default/files/ne_export_probe.json";
  $ok = FALSE; $why = "missing";
  if (file_exists($p)) {
    $raw = file_get_contents($p);
    $d = json_decode($raw, TRUE);
    if (is_array($d) && json_last_error() === JSON_ERROR_NONE) {
      $ok = str_contains($raw, "NE Export Probe");
      $why = $ok ? "ok" : "json-without-probe-title";
    } else { $why = "invalid-json"; }
  }
  print ($ok ? "PASS" : "FAIL") . " file=" . $p . " reason=" . $why . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
