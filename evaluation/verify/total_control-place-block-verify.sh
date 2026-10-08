#!/usr/bin/env bash
# Execution VERIFY: PASS when a block config entity 'tc_overview_block' exists using a Total
# Control Dashboard pane plugin (content_overview). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("tc_overview_block");
  $ok = $b && $b->getPluginId() === "content_overview";
  print (($ok) ? "PASS" : "FAIL") . " plugin=" . ($b ? $b->getPluginId() : "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
