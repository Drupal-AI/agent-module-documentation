#!/usr/bin/env bash
# Introspection SETUP: create two active accounts, ful_intro_active and ful_intro_idle, and
# give ONLY ful_intro_active a row in the core `sessions` table, so the agent must inspect the
# live site to say which account Force Users Logout would actually terminate. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  $db = \Drupal::database();
  foreach (["ful_intro_active", "ful_intro_idle"] as $name) {
    $u = user_load_by_name($name);
    if (!$u) {
      $u = User::create(["name" => $name, "mail" => $name . "@example.com", "pass" => \Drupal::service("password_generator")->generate(), "status" => 1]);
      $u->save();
    }
    $db->delete("sessions")->condition("uid", $u->id())->execute();
  }
  $active = user_load_by_name("ful_intro_active");
  $db->insert("sessions")->fields([
    "sid" => "ful_intro_active_sid", "uid" => $active->id(),
    "hostname" => "127.0.0.1", "timestamp" => time(), "session" => "",
  ])->execute();
  print "active uid=" . $active->id() . " sessions=" . $db->select("sessions", "s")->condition("uid", $active->id())->countQuery()->execute()->fetchField() . "\n";
' 2>/dev/null
echo "setup: ful_intro_active has a session, ful_intro_idle has none"
