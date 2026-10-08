#!/usr/bin/env bash
# Introspection SETUP: create an active user with email ru_known2@example.com and the
# requested username 'chosenhandle'; the presave hook overwrites the username with the email.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  if (!user_load_by_mail("ru_known2@example.com")) {
    User::create([
      "mail" => "ru_known2@example.com",
      "name" => "chosenhandle",
      "status" => 1,
      "pass" => "ru-eval-pass-2",
    ])->save();
  }
' >/dev/null 2>&1
echo "setup: user ru_known2@example.com created with requested name chosenhandle"
