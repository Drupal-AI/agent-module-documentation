#!/usr/bin/env bash
# Introspection SETUP: turn ON contact_emails.settings allow_charset_utf_8 (real boolean TRUE)
# so an agent can read the live value. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("contact_emails.settings")->set("allow_charset_utf_8", TRUE)->save();' >/dev/null 2>&1
echo "setup: contact_emails.settings allow_charset_utf_8 = true"
