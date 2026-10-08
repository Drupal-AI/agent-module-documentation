#!/usr/bin/env bash
# hard VERIFY (menu_item_limit): PASS when the mil_free menu is unlimited, i.e. its limit is
# 0/empty or the key is absent (that is how menu_item_limit treats 'unlimited'). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("menu_item_limit.settings")->get("mil_free");
  $ok = ($v === NULL || (int) $v === 0);
  print ($ok ? "PASS" : "FAIL") . " mil_free=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
