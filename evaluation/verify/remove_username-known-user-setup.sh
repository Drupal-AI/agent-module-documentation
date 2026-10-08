#!/usr/bin/env bash
# Introspection SETUP: create an active user whose email is ru_known@example.com but whose
# *requested* username is different; remove_username's presave forces name == email, so an
# inspecting agent should read back ru_known@example.com as the username. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  if (!user_load_by_mail("ru_known@example.com")) {
    User::create([
      "mail" => "ru_known@example.com",
      "name" => "ru_known_requested",
      "status" => 1,
      "pass" => "ru-eval-pass-1",
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: user with mail ru_known@example.com created (name forced to email by presave)"
