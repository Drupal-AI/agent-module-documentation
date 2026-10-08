#!/usr/bin/env bash
# Execution RESET: force contact_emails.settings allow_charset_utf_8 to boolean FALSE so verify
# FAILS until the agent turns it on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("contact_emails.settings")->set("allow_charset_utf_8", FALSE)->save();' >/dev/null 2>&1
echo "reset: contact_emails.settings allow_charset_utf_8 = false"
