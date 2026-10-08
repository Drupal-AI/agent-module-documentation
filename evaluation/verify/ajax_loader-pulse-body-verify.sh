#!/usr/bin/env bash
# HARD verify for the "use the Pulse throbber at the body selector" task.
# Reads ajax_loader.settings from live config. Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
#   throbber          == throbber_pulse
#   throbber_position == body
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("ajax_loader.settings");
  $throbber = (string) $c->get("throbber");
  $pos = (string) $c->get("throbber_position");
  $ok = ($throbber === "throbber_pulse" && $pos === "body");
  print ($ok ? "PASS" : "FAIL") . " throbber=" . $throbber . " position=" . $pos . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
