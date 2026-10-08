#!/usr/bin/env bash
# Execution CLEANUP: remove the rule used by the case. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\theme_switcher\Entity\ThemeSwitcherRule::load("ts_admin_rule")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: theme_switcher.rule.ts_admin_rule removed"
