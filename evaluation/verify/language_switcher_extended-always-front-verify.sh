#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the HARD "always link to the front page" task.
# PASS when language_switcher_extended.settings mode=always_link_to_front.
# Prints PASS/FAIL, exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("language_switcher_extended.settings");
  $mode = (string) $c->get("mode");
  $ok = ($mode === "always_link_to_front");
  print ($ok ? "PASS" : "FAIL") . " mode=" . $mode . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
