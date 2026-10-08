#!/usr/bin/env bash
# Execution VERIFY: PASS when link_field_tweak.settings add_another_link is truthy.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::config("link_field_tweak.settings")->get("add_another_link");
  $ok = !empty($v);
  print ($ok ? "PASS" : "FAIL") . " add_another_link=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
