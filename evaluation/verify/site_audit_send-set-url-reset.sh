#!/usr/bin/env bash
# Execution RESET: clear remote_url so verify FAILS until the agent sets it. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("site_audit_send.settings")->set("remote_url","")->save();' >/dev/null 2>&1
echo "reset: remote_url cleared"
