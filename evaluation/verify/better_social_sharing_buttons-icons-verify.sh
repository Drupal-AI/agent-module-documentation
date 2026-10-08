#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD verify: read better_social_sharing_buttons.settings and require the flat/monochrome icon
# set with circular icons:
#   iconset == social-icons--no-color
#   radius  == 100%
# Prints PASS/FAIL; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cfg = \Drupal::config("better_social_sharing_buttons.settings");
  $iconset = (string) $cfg->get("iconset");
  $radius  = (string) $cfg->get("radius");
  $i = ($iconset === "social-icons--no-color");
  $r = ($radius === "100%");
  print (($i && $r) ? "PASS" : "FAIL")
    . " iconset=" . ($i?1:0) . " radius=" . ($r?1:0)
    . " iconset=" . $iconset . " radius=" . $radius . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
