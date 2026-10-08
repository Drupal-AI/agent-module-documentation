#!/usr/bin/env bash
# Introspection SETUP: enable prevent_complete_own (non-default) in registration_workflow.settings.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::configFactory()->getEditable("registration_workflow.settings")->set("prevent_complete_own", TRUE)->save();' >/dev/null 2>&1
echo "setup: registration_workflow.settings prevent_complete_own=true"
