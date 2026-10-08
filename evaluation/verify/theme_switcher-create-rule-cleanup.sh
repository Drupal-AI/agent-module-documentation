#!/usr/bin/env bash
# Execution CLEANUP: remove the rule built during the case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\theme_switcher\Entity\ThemeSwitcherRule::load("ts_task_rule")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: theme_switcher.rule.ts_task_rule removed"
