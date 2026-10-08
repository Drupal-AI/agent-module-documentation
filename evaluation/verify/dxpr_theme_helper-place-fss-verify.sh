#!/usr/bin/env bash
# Execution VERIFY: PASS when a block with id dth_fss_task exists using the full_screen_search
# plugin AND its search_provider is set to search_api. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("dth_fss_task");
  $plugin = $b ? $b->getPluginId() : "none";
  $provider = $b ? ($b->get("settings")["search_provider"] ?? "unset") : "unset";
  $ok = ($plugin === "full_screen_search" && $provider === "search_api");
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " provider=" . $provider . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
