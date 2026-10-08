#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# HARD verify: read better_social_sharing_buttons.settings from the running site and require:
#   services enabled == EXACTLY {facebook, x, linkedin, whatsapp}   (no more, no fewer)
#   width == 32px
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cfg = \Drupal::config("better_social_sharing_buttons.settings");
  $enabled = [];
  foreach (($cfg->get("services") ?? []) as $s) {
    if (!empty($s["enabled"]) && isset($s["id"])) { $enabled[] = $s["id"]; }
  }
  sort($enabled);
  $want = ["facebook", "linkedin", "whatsapp", "x"];   // sorted
  $net = ($enabled === $want);
  $width = (string) $cfg->get("width");
  $w = ($width === "32px");
  print (($net && $w) ? "PASS" : "FAIL")
    . " networks=" . ($net?1:0) . " width=" . ($w?1:0)
    . " enabled=[" . implode(",", $enabled) . "] width=" . $width . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
