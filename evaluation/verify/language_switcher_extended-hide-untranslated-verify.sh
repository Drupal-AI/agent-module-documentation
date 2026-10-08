#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the HARD "hide untranslated language links" task.
# PASS when language_switcher_extended.settings has mode=process_untranslated AND
# untranslated_handler=hide_link. Prints PASS/FAIL, exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("language_switcher_extended.settings");
  $mode = (string) $c->get("mode");
  $h = (string) $c->get("untranslated_handler");
  $ok = ($mode === "process_untranslated" && $h === "hide_link");
  print ($ok ? "PASS" : "FAIL") . " mode=" . $mode . " untranslated_handler=" . $h . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
