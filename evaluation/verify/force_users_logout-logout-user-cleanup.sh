#!/usr/bin/env bash
# Execution CLEANUP: delete the ful_task_target / ful_task_keep fixture accounts and their
# session rows. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  foreach (["ful_task_target", "ful_task_keep"] as $name) {
    if ($u = user_load_by_name($name)) {
      $db->delete("sessions")->condition("uid", $u->id())->execute();
      $u->delete();
    }
  }
  foreach (["ful_task_target_sid", "ful_task_keep_sid"] as $sid) {
    $db->delete("sessions")->condition("sid", $sid)->execute();
  }
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: ful_task_target / ful_task_keep removed"
