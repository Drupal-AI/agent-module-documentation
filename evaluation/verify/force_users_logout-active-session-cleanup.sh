#!/usr/bin/env bash
# Introspection CLEANUP: delete the two fixture accounts and their session rows. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $db = \Drupal::database();
  foreach (["ful_intro_active", "ful_intro_idle"] as $name) {
    if ($u = user_load_by_name($name)) {
      $db->delete("sessions")->condition("uid", $u->id())->execute();
      $u->delete();
    }
  }
  $db->delete("sessions")->condition("sid", "ful_intro_active_sid")->execute();
  print "cleaned\n";
' 2>/dev/null
echo "cleanup: ful_intro_* accounts and sessions removed"
