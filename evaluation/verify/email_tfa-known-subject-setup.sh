#!/usr/bin/env bash
# Introspection SETUP: set a known OTP email subject on email_tfa.settings so an agent can read it
# back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("email_tfa.settings")->set("subject", "EMAILTFA Custom Subject 88")->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: email_tfa.settings subject='EMAILTFA Custom Subject 88'"
