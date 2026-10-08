#!/usr/bin/env bash
# Execution VERIFY: PASS when button_style==='pill' and scroll_speed===500. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("scroll_top_button.settings");
  $st = $c->get("button_style"); $sp = $c->get("scroll_speed");
  $ok = ($st === "pill" && (int) $sp === 500);
  print ($ok ? "PASS" : "FAIL") . " button_style=" . var_export($st, TRUE) . " scroll_speed=" . var_export($sp, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
