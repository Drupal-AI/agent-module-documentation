#!/usr/bin/env bash
# Execution CLEANUP: ensure the activity_log view is enabled (baseline). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.activity_log")->set("status", TRUE)->save();' >/dev/null 2>&1
echo "cleanup: views.view.activity_log status=true (baseline)"
