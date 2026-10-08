#!/usr/bin/env bash
# Introspection SETUP: write a known Persistent Login configuration so an agent can read the
# lifetime / label / token limit back off the live site. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("persistent_login.settings")
    ->set("lifetime", 14)
    ->set("extend_lifetime", TRUE)
    ->set("max_tokens", 3)
    ->set("login_form.field_label", "Keep me signed in on this device")
    ->set("cookie_prefix", "PL")
    ->save();
' >/dev/null 2>&1
echo "setup: persistent_login.settings lifetime=14 extend=TRUE max_tokens=3 label='Keep me signed in on this device'"
