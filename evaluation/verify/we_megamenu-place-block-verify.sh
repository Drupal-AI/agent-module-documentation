#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled block using plugin we_megamenu_block:we_mm_menu2 has been
# placed (in any theme/region). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $found = NULL;
  foreach (Block::loadMultiple() as $block) {
    if ($block->getPluginId() === "we_megamenu_block:we_mm_menu2" && $block->status()) {
      $found = $block->id() . "@" . $block->getTheme() . ":" . $block->getRegion();
      break;
    }
  }
  print ($found ? "PASS block=" . $found : "FAIL block=none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
