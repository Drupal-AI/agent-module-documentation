#!/usr/bin/env bash
# Live-state verification for the responsive_menu "build config" task.
# Passes when responsive_menu.settings has, live: horizontal_menu=main,
# horizontal_breakpoint=Nav (the "(min-width: 1200px)" breakpoint), and drag enabled.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("responsive_menu.settings");
  $menu = (string) $c->get("horizontal_menu");
  $bp   = (string) $c->get("horizontal_breakpoint");
  $drag = (bool) $c->get("drag");
  $m  = ($menu === "main");
  $b  = ($bp === "Nav");
  $d  = ($drag === TRUE);
  print (($m && $b && $d) ? "PASS" : "FAIL")
    . " menu=" . $menu . " breakpoint=" . $bp . " drag=" . ($drag ? "1" : "0") . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
