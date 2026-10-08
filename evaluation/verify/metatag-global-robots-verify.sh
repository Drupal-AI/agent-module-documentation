#!/usr/bin/env bash
# Live-state verification for the "global robots + canonical_url defaults" execution task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the metatag_defaults `global` config entity has:
#   tags.robots        exactly  noindex, nofollow, noarchive
#   tags.canonical_url exactly  [node:url]
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $tags = \Drupal::config("metatag.metatag_defaults.global")->get("tags") ?: [];
  $robots    = $tags["robots"] ?? "";
  $canonical = $tags["canonical_url"] ?? "";
  $r = $robots === "noindex, nofollow, noarchive";
  $c = $canonical === "[node:url]";
  print (($r && $c) ? "PASS" : "FAIL")
    . " robots=" . ($r?1:0) . " canonical=" . ($c?1:0)
    . " | robots=[" . $robots . "] canonical_url=[" . $canonical . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
