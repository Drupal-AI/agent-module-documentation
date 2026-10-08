#!/usr/bin/env bash
# Introspection CLEANUP: delete the rule created by the matching setup. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($r = \Drupal\theme_switcher\Entity\ThemeSwitcherRule::load("ts_known_rule")) { $r->delete(); }
' >/dev/null 2>&1
echo "cleanup: theme_switcher.rule.ts_known_rule removed"
