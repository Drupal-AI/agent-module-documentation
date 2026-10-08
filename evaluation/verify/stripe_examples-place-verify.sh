#!/usr/bin/env bash
# HARD VERIFY: PASS when an enabled block with id stripe_ex_task and plugin
# stripe_example_checkout exists. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("stripe_ex_task");
  $ok = $b && $b->getPluginId() === "stripe_example_checkout" && $b->status();
  print ($ok ? "PASS" : "FAIL") . " plugin=" . ($b ? $b->getPluginId() : "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
