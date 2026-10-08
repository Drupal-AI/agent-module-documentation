#!/usr/bin/env bash
# Introspection SETUP: configure user_redirect ignore paths (/user/reset/* and /promo/*) and
# apply them to login, so the agent can read which paths are ignored for login. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("user_redirect.settings");
  $c->set("ignore", ["/user/reset/*", "/promo/*"])
    ->set("ignore_for", ["login" => "login", "logout" => 0])
    ->save();
' >/dev/null 2>&1
echo "setup: user_redirect ignore=[/user/reset/*, /promo/*], ignore_for.login on"
