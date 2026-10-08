#!/usr/bin/env bash
# Execution RESET: reset exclude paths to placeholder so verify FAILS until the agent adds
# the /node/add exclusion. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("admin_theme.settings")->set("exclude_paths", "/dummy-path-needed-until-core-issue-2930364-is-fixed")->save();
' >/dev/null 2>&1
echo "reset: admin_theme.settings exclude_paths=placeholder"
