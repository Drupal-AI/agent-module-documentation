#!/usr/bin/env bash
# Introspection SETUP: set the change-host flow to single-step (non-default).
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("registration_change_host.settings")->set("workflow", "single_step")->save();' >/dev/null 2>&1
echo "setup: registration_change_host.settings workflow=single_step"
