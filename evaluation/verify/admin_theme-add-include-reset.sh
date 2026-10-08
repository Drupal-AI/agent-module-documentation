#!/usr/bin/env bash
# Execution RESET: reset include paths to the shipped placeholder (matches nothing) so verify
# FAILS until the agent adds the dashboard path. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("admin_theme.settings")->set("paths", "/dummy-path-needed-until-core-issue-2930364-is-fixed")->save();
' >/dev/null 2>&1
echo "reset: admin_theme.settings paths=placeholder"
