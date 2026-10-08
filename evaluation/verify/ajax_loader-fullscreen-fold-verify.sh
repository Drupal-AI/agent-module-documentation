#!/usr/bin/env bash
# HARD verify for the "Folding cube throbber, full-screen overlay, core message hidden" task.
# Reads ajax_loader.settings from live config. Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
#   throbber          == throbber_folding_cube
#   always_fullscreen == TRUE
#   hide_ajax_message == TRUE
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("ajax_loader.settings");
  $throbber = (string) $c->get("throbber");
  $fs = (bool) $c->get("always_fullscreen");
  $hide = (bool) $c->get("hide_ajax_message");
  $ok = ($throbber === "throbber_folding_cube" && $fs && $hide);
  print ($ok ? "PASS" : "FAIL")
    . " throbber=" . $throbber
    . " always_fullscreen=" . ($fs ? "1" : "0")
    . " hide_ajax_message=" . ($hide ? "1" : "0") . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
