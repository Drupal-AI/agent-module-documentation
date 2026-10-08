#!/usr/bin/env bash
# Execution VERIFY: PASS when an enabled dark_mode_toggle block is placed in the olivero
# 'sidebar' region. Prints PASS/FAIL; exit 0 / 1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $hit = NULL;
  foreach (Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "dark_mode_toggle" && $b->status() && $b->getTheme() === "olivero" && $b->getRegion() === "sidebar") { $hit = $b->id(); break; }
  }
  print ($hit ? "PASS block=" . $hit : "FAIL no enabled dark_mode_toggle block in olivero:sidebar") . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
