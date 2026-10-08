#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD verify: read the live config and require that SOME simple_popup_blocks.popup_<uid>
# object targets custom CSS class .exit-offer, bottom-right, exit-intent, enabled:
#   identifier == "exit-offer"   type == 1   css_selector == 0 (class/.)
#   layout == 3 (bottom-right)   trigger_method == 2 (before browser/tab close)   status truthy
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cf = \Drupal::configFactory();
  $hit = NULL;
  foreach ($cf->listAll("simple_popup_blocks.popup_") as $name) {
    $c = $cf->get($name);
    if ((string) $c->get("identifier") === "exit-offer") { $hit = $c; break; }
  }
  if (!$hit) { print "FAIL no-popup-with-identifier=exit-offer\n"; return; }
  $type    = (int) $hit->get("type") === 1;
  $sel     = (int) $hit->get("css_selector") === 0;
  $layout  = (int) $hit->get("layout") === 3;
  $trigger = (int) $hit->get("trigger_method") === 2;
  $status  = (bool) $hit->get("status");
  $ok = $type && $sel && $layout && $trigger && $status;
  print ($ok ? "PASS" : "FAIL")
    . " type=" . ($type?1:0) . " css_selector=" . ($sel?1:0)
    . " layout=" . ($layout?1:0) . " trigger=" . ($trigger?1:0)
    . " status=" . ($status?1:0)
    . " [layout=" . $hit->get("layout") . " trigger_method=" . $hit->get("trigger_method") . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
