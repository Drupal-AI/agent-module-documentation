#!/usr/bin/env bash
# Introspection SETUP: enable Mail Safety rerouting to a known default address so an
# inspecting agent can read it back from mail_safety.settings. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("mail_safety.settings")
    ->set("enabled", TRUE)
    ->set("send_mail_to_default_mail", TRUE)
    ->set("default_mail_address", "mailsafety_probe@qa.example")
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: mail_safety reroutes to mailsafety_probe@qa.example"
