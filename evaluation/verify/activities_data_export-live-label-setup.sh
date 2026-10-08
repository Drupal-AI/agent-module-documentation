#!/usr/bin/env bash
# Introspection SETUP: set a known label on the activity_log view so an inspecting agent can
# read it back. Baseline label is "Activities Log". Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.activity_log")->set("label", "ADE Audit Log")->save();' >/dev/null 2>&1
echo "setup: views.view.activity_log label=ADE Audit Log"
