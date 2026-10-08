#!/usr/bin/env bash
# Live-state verification for the "per-bundle Article metatag defaults" execution task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the metatag_defaults `node__article` config entity exists with:
#   tags.canonical_url exactly  [node:url]
#   tags.og_type       exactly  article
#   tags.og_title      exactly  [node:title] | Eval OG
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $tags = \Drupal::config("metatag.metatag_defaults.node__article")->get("tags") ?: [];
  $canonical = $tags["canonical_url"] ?? "";
  $ogtype    = $tags["og_type"] ?? "";
  $ogtitle   = $tags["og_title"] ?? "";
  $c = $canonical === "[node:url]";
  $t = $ogtype === "article";
  $o = $ogtitle === "[node:title] | Eval OG";
  print (($c && $t && $o) ? "PASS" : "FAIL")
    . " canonical=" . ($c?1:0) . " og_type=" . ($t?1:0) . " og_title=" . ($o?1:0)
    . " | canonical=[" . $canonical . "] og_type=[" . $ogtype . "] og_title=[" . $ogtitle . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
