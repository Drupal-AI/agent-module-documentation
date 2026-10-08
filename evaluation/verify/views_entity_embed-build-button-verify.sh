#!/usr/bin/env bash
# VERIFY: PASS when embed button vee_btn exists with type_id embed_views.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $b = \Drupal::entityTypeManager()->getStorage("embed_button")->load("vee_btn");
  $tid = $b ? $b->getTypeId() : "none";
  $ok = ($tid === "embed_views");
  print ($ok ? "PASS" : "FAIL") . " button=" . ($b ? "yes" : "no") . " type_id=" . $tid . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
