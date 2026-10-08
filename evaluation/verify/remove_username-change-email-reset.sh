#!/usr/bin/env bash
# Execution RESET: (re)create the baseline account with email ru_task2@example.com and remove
# any ru_new2@example.com account, so verify FAILS until the agent changes the email.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\user\Entity\User;
  if ($u = user_load_by_mail("ru_new2@example.com")) { $u->delete(); }
  if ($u = user_load_by_name("ru_new2@example.com")) { $u->delete(); }
  if (!user_load_by_mail("ru_task2@example.com")) {
    User::create([
      "mail" => "ru_task2@example.com",
      "name" => "ru_task2@example.com",
      "status" => 1,
      "pass" => "ru-eval-pass-3",
    ])->save();
  }
' >/dev/null 2>&1
echo "reset: baseline account ru_task2@example.com present, ru_new2@example.com absent"
