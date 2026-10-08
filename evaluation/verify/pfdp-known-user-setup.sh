#!/usr/bin/env bash
# Introspection SETUP: turn ON pfdp.settings:by_user_checks (creating the settings object,
# which does NOT exist after a plain install) and register the directory pfdp_intro_user
# (/pfdp-intro-user) granting exactly one individual account, pfdp_intro_reader. A decoy
# account pfdp_intro_other is created but not granted. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\pfdp\Entity\DirectoryEntity;
  use Drupal\user\Entity\User;
  foreach (["pfdp_intro_reader", "pfdp_intro_other"] as $name) {
    if (!user_load_by_name($name)) {
      User::create(["name" => $name, "mail" => $name . "@example.com", "pass" => \Drupal::service("password_generator")->generate(), "status" => 1])->save();
    }
  }
  $reader = user_load_by_name("pfdp_intro_reader");
  \Drupal::configFactory()->getEditable("pfdp.settings")
    ->set("by_user_checks", TRUE)->set("cache_users", FALSE)
    ->set("attachment_mode", FALSE)->set("override_mode", FALSE)
    ->set("debug_mode", FALSE)->save();
  if ($existing = DirectoryEntity::load("pfdp_intro_user")) { $existing->delete(); }
  DirectoryEntity::create([
    "id" => "pfdp_intro_user", "path" => "/pfdp-intro-user", "bypass" => FALSE,
    "grant_file_owners" => FALSE, "users" => [(string) $reader->id()], "roles" => [],
  ])->save();
  print "reader uid=" . $reader->id() . " by_user_checks=" . var_export(\Drupal::config("pfdp.settings")->get("by_user_checks"), TRUE) . "\n";
' 2>/dev/null
echo "setup: /pfdp-intro-user granted to the uid of pfdp_intro_reader, by_user_checks=TRUE"
