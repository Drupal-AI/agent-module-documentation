#!/usr/bin/env bash
# Execution VERIFY: PASS when webform wfx_pref has saved results-export settings whose
# exporter is the xlsx plugin provided by webform_xlsx_export, with machine-name headers.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $w = \Drupal\webform\Entity\Webform::load("wfx_pref");
  if (!$w) { print "FAIL webform=missing\n"; return; }
  $state = $w->getState("results.export", []);
  $exporter = $state["exporter"] ?? NULL;
  $header = $state["header_format"] ?? NULL;
  $ok = ($exporter === "xlsx") && ($header === "key");
  print ($ok ? "PASS" : "FAIL") . " exporter=" . var_export($exporter, TRUE)
    . " header_format=" . var_export($header, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
