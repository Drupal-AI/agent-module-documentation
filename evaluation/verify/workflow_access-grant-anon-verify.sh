#!/usr/bin/env bash
# Execution VERIFY: PASS when workflow_access.role[wa_wf_published] grants the anonymous role view.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $g = \Drupal::config("workflow_access.role")->get("wa_wf_published");
  $an = is_array($g) ? ($g["anonymous"] ?? NULL) : NULL;
  $ok = $an && !empty($an["grant_view"]);
  print ($ok ? "PASS" : "FAIL") . " grant=" . var_export($an, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
