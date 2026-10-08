#!/usr/bin/env bash
# Execution VERIFY: PASS when node form mode 'fmm_exclude' is in
# form_mode_manager.settings form_modes.node.to_exclude. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ex = \Drupal::config("form_mode_manager.settings")->get("form_modes.node.to_exclude") ?? [];
  $ok = in_array("fmm_exclude", array_values($ex), TRUE);
  print ($ok ? "PASS" : "FAIL") . " to_exclude=" . implode(",", array_values($ex)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
