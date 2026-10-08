#!/usr/bin/env bash
# Execution VERIFY: PASS when a published media_gallery entity titled "MG Task Gallery" exists.
# Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("media_gallery");
  $found = $s->loadByProperties(["title" => "MG Task Gallery"]);
  $pub = FALSE;
  foreach ($found as $g) { if ((bool) $g->get("status")->value) { $pub = TRUE; } }
  $ok = (!empty($found) && $pub);
  print ($ok ? "PASS" : "FAIL") . " count=" . count($found) . " published=" . var_export($pub, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
