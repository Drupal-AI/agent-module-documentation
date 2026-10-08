#!/usr/bin/env bash
# Execution VERIFY: PASS when block.block.mbt_task has modify_title === TRUE. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("mbt_task");
  $v = $b ? $b->getThirdPartySetting("menu_block_title", "modify_title") : NULL;
  $ok = ($v === TRUE || $v === 1 || $v === "1");
  print ($ok ? "PASS" : "FAIL") . " modify_title=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
