#!/usr/bin/env bash
# Introspection CLEANUP: restore the shipped label ("Activities Log"). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("views.view.activity_log")->set("label", "Activities Log")->save();' >/dev/null 2>&1
echo "cleanup: views.view.activity_log label=Activities Log (baseline)"
