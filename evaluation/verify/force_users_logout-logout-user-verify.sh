#!/usr/bin/env bash
# Execution VERIFY for "force ful_task_target to log out, leave ful_task_keep alone".
# PASS when the `sessions` table has NO row for ful_task_target and STILL has a row for
# ful_task_keep. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $db = \Drupal::database();
  $t = user_load_by_name("ful_task_target");
  $k = user_load_by_name("ful_task_keep");
  $tc = $t ? (int) $db->select("sessions", "s")->condition("uid", $t->id())->countQuery()->execute()->fetchField() : -1;
  $kc = $k ? (int) $db->select("sessions", "s")->condition("uid", $k->id())->countQuery()->execute()->fetchField() : -1;
  $ok = ($tc === 0 && $kc > 0);
  print ($ok ? "PASS" : "FAIL") . " target_sessions=$tc keep_sessions=$kc\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
