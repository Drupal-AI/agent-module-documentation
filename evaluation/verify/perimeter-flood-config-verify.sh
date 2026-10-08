#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD (execution) live-state verification for the "3 attempts before ban" task.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
# PASS when perimeter.settings:flood_threshold === 3 (a visitor gets 3 matching
# 404s and is banned on the next one). flood_window must stay a positive integer.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::config("perimeter.settings");
  $t = $c->get("flood_threshold");
  $w = $c->get("flood_window");
  $ok = ((int) $t === 3) && ((int) $w >= 1);
  print ($ok ? "PASS" : "FAIL") . " flood_threshold=" . var_export($t, TRUE) . " flood_window=" . var_export($w, TRUE) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
