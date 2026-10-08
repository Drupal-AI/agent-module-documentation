#!/usr/bin/env bash
# Execution RESET: create (or reuse) two active accounts ful_task_target and ful_task_keep and
# give BOTH a row in the core `sessions` table, so the matching verify FAILS until the agent
# forces a logout of ful_task_target only. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $db = \Drupal::database();
  foreach (["ful_task_target" => "ful_task_target_sid", "ful_task_keep" => "ful_task_keep_sid"] as $name => $sid) {
    $u = user_load_by_name($name);
    if (!$u) {
      $u = User::create(["name" => $name, "mail" => $name . "@example.com", "pass" => \Drupal::service("password_generator")->generate(), "status" => 1]);
      $u->save();
    }
    $db->delete("sessions")->condition("uid", $u->id())->execute();
    $db->delete("sessions")->condition("sid", $sid)->execute();
    $db->insert("sessions")->fields([
      "sid" => $sid, "uid" => $u->id(),
      "hostname" => "127.0.0.1", "timestamp" => time(), "session" => "",
    ])->execute();
    print $name . " uid=" . $u->id() . " sessions=" . $db->select("sessions", "s")->condition("uid", $u->id())->countQuery()->execute()->fetchField() . "\n";
  }
' 2>/dev/null
echo "reset: ful_task_target and ful_task_keep both have an active session"
