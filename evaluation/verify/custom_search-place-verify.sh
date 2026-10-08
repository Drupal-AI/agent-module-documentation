#!/usr/bin/env bash
# HARD VERIFY: PASS when an enabled block with plugin 'custom_search' and id custom_search_task
# exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("custom_search_task");
  $ok = $b && $b->getPluginId() === "custom_search" && $b->status();
  print ($ok ? "PASS" : "FAIL") . " plugin=" . ($b ? $b->getPluginId() : "none") . " status=" . ($b ? var_export($b->status(),true) : "n/a") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
