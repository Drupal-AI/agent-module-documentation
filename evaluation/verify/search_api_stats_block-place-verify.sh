#!/usr/bin/env bash
# Execution VERIFY: PASS when a block config entity is placed with plugin
# search_api_stats_block:sasblk_idx (in any theme/region). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = "none";
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->get("plugin") === "search_api_stats_block:sasblk_idx") { $found = $b->id(); break; }
  }
  print (($found !== "none") ? "PASS" : "FAIL") . " block=" . $found . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
