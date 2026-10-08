#!/usr/bin/env bash
# Live-state verification for the "second GA4 container with a non-default setting" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if a google_tag_container config entity with id `eval_ga4` exists, is enabled,
# carries the G-EVAL4TEST measurement ID in tag_container_ids, and has a non-default
# weight of 10 (default weight is 0).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::entityTypeManager()->getStorage("google_tag_container")->load("eval_ga4");
  $exists = (bool) $c;
  $enabled = $exists && $c->status();
  $ids = $exists ? array_values((array) $c->get("tag_container_ids")) : [];
  $hasid = in_array("G-EVAL4TEST", $ids, TRUE);
  $weight = $exists ? (int) $c->get("weight") : 0;
  $wok = $weight === 10;
  print (($exists && $enabled && $hasid && $wok) ? "PASS" : "FAIL")
    . " exists=" . ($exists?1:0) . " enabled=" . ($enabled?1:0)
    . " hasid=" . ($hasid?1:0) . " weight=" . $weight
    . " | ids=[" . implode(",", $ids) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
