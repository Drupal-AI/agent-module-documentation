#!/usr/bin/env bash
# Introspection CLEANUP: clear remote_url (baseline). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("site_audit_send.settings")->set("remote_url","")->save();' >/dev/null 2>&1
echo "cleanup: remote_url cleared"
