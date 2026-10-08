#!/usr/bin/env bash
# Execution VERIFY: PASS when enabled==='on' (string) and button_text==='To top'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("scroll_top_button.settings");
  $en = $c->get("enabled"); $bt = $c->get("button_text");
  $ok = ($en === "on" && $bt === "To top");
  print ($ok ? "PASS" : "FAIL") . " enabled=" . var_export($en, TRUE) . " button_text=" . var_export($bt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
