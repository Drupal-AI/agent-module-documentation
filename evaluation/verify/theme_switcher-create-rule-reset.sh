#!/usr/bin/env bash
# Execution RESET: make sure the rule the agent must build does not exist. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\theme_switcher\Entity\ThemeSwitcherRule::load("ts_task_rule")) { $r->delete(); }
' >/dev/null 2>&1
echo "reset: theme_switcher.rule.ts_task_rule absent"
