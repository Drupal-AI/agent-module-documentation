#!/usr/bin/env bash
# Live-state verification for the "global Metatag SEO defaults" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if the metatag_defaults `global` config entity has:
#   tags.title       exactly  [node:title] | [site:name]
#   tags.description exactly  Powered by Drupal — eval defaults
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $tags = \Drupal::config("metatag.metatag_defaults.global")->get("tags") ?: [];
  $title = $tags["title"] ?? "";
  $desc  = $tags["description"] ?? "";
  $t = $title === "[node:title] | [site:name]";
  $d = $desc  === "Powered by Drupal — eval defaults";
  print (($t && $d) ? "PASS" : "FAIL") . " title=" . ($t?1:0) . " desc=" . ($d?1:0)
    . " | title=[" . $title . "] description=[" . $desc . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
