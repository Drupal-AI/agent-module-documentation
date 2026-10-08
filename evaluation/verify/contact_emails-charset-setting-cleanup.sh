#!/usr/bin/env bash
# Introspection CLEANUP: restore contact_emails.settings allow_charset_utf_8 to shipped default
# (boolean FALSE). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("contact_emails.settings")->set("allow_charset_utf_8", FALSE)->save();' >/dev/null 2>&1
echo "cleanup: contact_emails.settings allow_charset_utf_8 = false"
