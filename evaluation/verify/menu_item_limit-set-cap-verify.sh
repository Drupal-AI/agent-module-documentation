#!/usr/bin/env bash
# hard VERIFY (menu_item_limit): PASS when menu_item_limit.settings:mil_task === 2. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("menu_item_limit.settings")->get("mil_task");
  $ok = ($v !== NULL && (int) $v === 2);
  print ($ok ? "PASS" : "FAIL") . " mil_task=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
