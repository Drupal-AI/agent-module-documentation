#!/usr/bin/env bash
# Execution VERIFY: PASS when a block 'cvfb_task' exists using the configurable exposed-filter
# plugin for the test view, with visible_filters containing 'title' but NOT 'uid'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("cvfb_task");
  $plugin = $b ? $b->get("plugin") : "none";
  $vf = $b ? array_keys(array_filter((array) ($b->get("settings")["visible_filters"] ?? []))) : [];
  $ok = (strpos($plugin, "configurable_views_filter_block_block:") === 0)
        && in_array("title", $vf, TRUE) && !in_array("uid", $vf, TRUE);
  print ($ok ? "PASS" : "FAIL") . " plugin=" . $plugin . " visible=" . implode(",", $vf) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
