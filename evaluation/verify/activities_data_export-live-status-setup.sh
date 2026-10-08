#!/usr/bin/env bash
# Introspection SETUP: disable the activity_log view so an inspecting agent can read its status.
# Baseline is enabled (status true). Uses raw config to avoid Views handler discovery.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.activity_log")->set("status", FALSE)->save();' >/dev/null 2>&1
echo "setup: views.view.activity_log status=false (disabled)"
