#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one enabled block placement uses the dark_mode_toggle
# plugin (any theme/region). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $found = NULL;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "dark_mode_toggle" && $b->status()) {
      $found = $b->id() . "@" . $b->getTheme() . ":" . $b->getRegion(); break;
    }
  }
  print ($found ? "PASS block=" . $found : "FAIL no enabled dark_mode_toggle block") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
