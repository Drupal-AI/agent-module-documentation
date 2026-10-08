#!/usr/bin/env bash
# HARD verify: Chart.js must be configured to load from the CDN, i.e.
# moderation_dashboard.settings:chart_js_cdn === true (boolean).
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# SPDX-License-Identifier: GPL-2.0-or-later
set -uo pipefail
cd /var/www/html

val=$(drush php:eval '
  $v = \Drupal::config("moderation_dashboard.settings")->get("chart_js_cdn");
  print "MDCDN:" . (($v === TRUE) ? "cdn" : "local");
' 2>/dev/null | grep -oE 'MDCDN:(cdn|local)')

if [ "$val" = "MDCDN:cdn" ]; then
  echo "PASS chart_js_cdn is enabled (true) — Chart.js served from CDN"
  exit 0
else
  echo "FAIL chart_js_cdn is not enabled ($val)"
  exit 1
fi
