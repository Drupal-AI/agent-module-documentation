#!/usr/bin/env bash
# Execution RESET: clear user 1's filter_perms selection so verify FAILS until the agent stores an
# "all roles, all modules" (ALL_OPTIONS = -1) selection.
set -uo pipefail
cd /var/www/html
drush php:eval '\Drupal::keyValueExpirable("filter_perms_list")->delete("1");' >/dev/null 2>&1
echo "reset: filter_perms_list[1] cleared"
