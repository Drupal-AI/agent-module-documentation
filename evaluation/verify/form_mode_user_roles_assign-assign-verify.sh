#!/usr/bin/env bash
# Execution VERIFY: PASS when the 'task' user form mode assigns role fmra_task, i.e.
# form_modes.user_task.assign_roles contains fmra_task. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $r = \Drupal::config("form_mode_user_roles_assign.settings")->get("form_modes.user_task.assign_roles") ?? [];
  $vals = array_merge(array_keys($r), array_values($r));
  $ok = in_array("fmra_task", $vals, TRUE);
  print ($ok ? "PASS" : "FAIL") . " assign_roles=" . implode(",", array_values($r)) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
