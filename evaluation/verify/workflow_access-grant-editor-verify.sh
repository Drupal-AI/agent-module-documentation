#!/usr/bin/env bash
# Execution VERIFY: PASS when workflow_access.role[wa_wf_review] grants the content_editor role
# both view and update. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $g = \Drupal::config("workflow_access.role")->get("wa_wf_review");
  $ce = is_array($g) ? ($g["content_editor"] ?? NULL) : NULL;
  $ok = $ce && !empty($ce["grant_view"]) && !empty($ce["grant_update"]);
  print ($ok ? "PASS" : "FAIL") . " grant=" . var_export($ce, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
