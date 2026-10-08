#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'team' user form mode assigns BOTH fmra_team_a and fmra_team_b.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::config("form_mode_user_roles_assign.settings")->get("form_modes.user_team.assign_roles") ?? [];
  $vals = array_merge(array_keys($r), array_values($r));
  $ok = in_array("fmra_team_a", $vals, TRUE) && in_array("fmra_team_b", $vals, TRUE);
  print ($ok ? "PASS" : "FAIL") . " assign_roles=" . implode(",", array_values($r)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
