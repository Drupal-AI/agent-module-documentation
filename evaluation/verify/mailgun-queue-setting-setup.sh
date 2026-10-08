#!/usr/bin/env bash
# Introspection SETUP: turn Mailgun's use_queue ON (baseline default false) so an inspecting
# agent can read that queued/cron sending is enabled. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("mailgun.settings")->set("use_queue", TRUE)->save();' >/dev/null 2>&1
echo "setup: mailgun.settings use_queue=true"
