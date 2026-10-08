#!/usr/bin/env bash
# Introspection CLEANUP: delete the two competing rules. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\theme_switcher\Entity\ThemeSwitcherRule;
  foreach (["ts_order_alpha", "ts_order_beta"] as $id) {
    if ($r = ThemeSwitcherRule::load($id)) { $r->delete(); }
  }
' >/dev/null 2>&1
echo "cleanup: ts_order_alpha and ts_order_beta removed"
