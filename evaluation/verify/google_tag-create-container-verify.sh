#!/usr/bin/env bash
# Live-state verification for the "create a GTM tag container" execution task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# PASS only if a google_tag_container config entity with id `eval_container` exists,
# is enabled, and carries the GTM-EVAL01 tag ID in its tag_container_ids property.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $c = \Drupal::entityTypeManager()->getStorage("google_tag_container")->load("eval_container");
  $exists = (bool) $c;
  $enabled = $exists && $c->status();
  $ids = $exists ? array_values((array) $c->get("tag_container_ids")) : [];
  $hasid = in_array("GTM-EVAL01", $ids, TRUE);
  print (($exists && $enabled && $hasid) ? "PASS" : "FAIL")
    . " exists=" . ($exists?1:0) . " enabled=" . ($enabled?1:0) . " hasid=" . ($hasid?1:0)
    . " | ids=[" . implode(",", $ids) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
