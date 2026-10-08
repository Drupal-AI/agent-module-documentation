#!/usr/bin/env bash
# Execution CLEANUP: delete the ful_task_role role, its fixture members and ful_task_other,
# plus their session rows. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  $db = \Drupal::database();
  foreach (["ful_task_member1", "ful_task_member2", "ful_task_other"] as $name) {
    if ($u = user_load_by_name($name)) {
      $db->delete("sessions")->condition("uid", $u->id())->execute();
      $u->delete();
    }
    $db->delete("sessions")->condition("sid", $name . "_sid")->execute();
  }
  if ($r = Role::load("ful_task_role")) { $r->delete(); }
  print "cleaned\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "cleanup: ful_task_role and members removed"
