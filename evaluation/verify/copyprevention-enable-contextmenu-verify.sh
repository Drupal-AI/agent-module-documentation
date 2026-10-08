#!/usr/bin/env bash
# Execution VERIFY: PASS when copyprevention.settings copyprevention_body enables the contextmenu
# (right-click) option with a truthy value.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal::config("copyprevention.settings")->get("copyprevention_body");
  $v = is_array($b) ? ($b["contextmenu"] ?? NULL) : NULL;
  $ok = !empty($v);
  print ($ok ? "PASS" : "FAIL") . " contextmenu=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
