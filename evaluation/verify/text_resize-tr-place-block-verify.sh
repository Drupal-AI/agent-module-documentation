#!/usr/bin/env bash
# Execution VERIFY: PASS when a block with plugin text_resize_block is placed (in any region
# of any theme) and enabled.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = "";
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $id => $b) {
    if ($b->getPluginId() === "text_resize_block" && $b->status()) {
      $found = $id . "@" . $b->getTheme() . ":" . $b->getRegion();
      break;
    }
  }
  $ok = $found !== "";
  print ($ok ? "PASS" : "FAIL") . " block=" . ($found ?: "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
