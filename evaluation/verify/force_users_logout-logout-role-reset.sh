#!/usr/bin/env bash
# Execution RESET: create role ful_task_role, two members (ful_task_member1, ful_task_member2)
# and one non-member (ful_task_other), and give all three a row in the core `sessions` table,
# so the matching verify FAILS until the agent logs the role's members out. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\Role;
  use Drupal\user\Entity\User;
  $db = \Drupal::database();
  if (!Role::load("ful_task_role")) { Role::create(["id" => "ful_task_role", "label" => "FUL Task Role"])->save(); }
  $spec = ["ful_task_member1" => TRUE, "ful_task_member2" => TRUE, "ful_task_other" => FALSE];
  foreach ($spec as $name => $member) {
    $u = user_load_by_name($name);
    if (!$u) {
      $u = User::create(["name" => $name, "mail" => $name . "@example.com", "pass" => \Drupal::service("password_generator")->generate(), "status" => 1]);
      $u->save();
    }
    if ($member && !$u->hasRole("ful_task_role")) { $u->addRole("ful_task_role"); $u->save(); }
    if (!$member && $u->hasRole("ful_task_role")) { $u->removeRole("ful_task_role"); $u->save(); }
    $sid = $name . "_sid";
    $db->delete("sessions")->condition("uid", $u->id())->execute();
    $db->delete("sessions")->condition("sid", $sid)->execute();
    $db->insert("sessions")->fields([
      "sid" => $sid, "uid" => $u->id(),
      "hostname" => "127.0.0.1", "timestamp" => time(), "session" => "",
    ])->execute();
    print $name . " uid=" . $u->id() . " role=" . var_export($u->hasRole("ful_task_role"), TRUE) . "\n";
  }
' 2>/dev/null
drush cr >/dev/null 2>&1
echo "reset: ful_task_role members and ful_task_other all have an active session"
