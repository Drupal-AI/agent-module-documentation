#!/usr/bin/env bash
# Execution VERIFY: PASS when shariff.settings has both linkedin and mail among services and
# theme = white. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("shariff.settings");
  $services = array_values($c->get("shariff_services") ?? []);
  $theme = $c->get("shariff_theme");
  $ok = in_array("linkedin",$services,true) && in_array("mail",$services,true) && $theme === "white";
  print ($ok ? "PASS" : "FAIL") . " services=" . implode(",",$services) . " theme=" . var_export($theme,true) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
