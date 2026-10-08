#!/usr/bin/env bash
# Execution VERIFY for "force logout of every user holding the ful_task_role role".
# PASS when neither ful_task_member1 nor ful_task_member2 has a row in `sessions` and the
# non-member ful_task_other still has one. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $db = \Drupal::database();
  $c = function ($name) use ($db) {
    $u = user_load_by_name($name);
    return $u ? (int) $db->select("sessions", "s")->condition("uid", $u->id())->countQuery()->execute()->fetchField() : -1;
  };
  $m1 = $c("ful_task_member1"); $m2 = $c("ful_task_member2"); $o = $c("ful_task_other");
  $ok = ($m1 === 0 && $m2 === 0 && $o > 0);
  print ($ok ? "PASS" : "FAIL") . " member1=$m1 member2=$m2 other=$o\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
