#!/usr/bin/env bash
# Execution VERIFY (tocbot): PASS when at least one ENABLED block instance uses the tocbot_block
# plugin (the "Tocbot TOC" block has been placed in a region). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = NULL;
  foreach (\Drupal\block\Entity\Block::loadMultiple() as $b) {
    if ($b->getPluginId() === "tocbot_block" && $b->status()) {
      $found = $b->id() . "@" . $b->getTheme() . ":" . $b->getRegion();
      break;
    }
  }
  print ($found ? "PASS placement=" . $found : "FAIL placement=none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
