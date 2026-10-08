#!/usr/bin/env bash
# Execution VERIFY: PASS when block_classes_task carries the Block Classes third-party setting
# block_class with both "promo-card" and "is-highlighted" (order/extra whitespace tolerated).
# Prints PASS/FAIL. exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("block_classes_task");
  $v = $b ? (string) $b->getThirdPartySetting("block_classes", "block_class") : "";
  $parts = preg_split("/\s+/", trim($v), -1, PREG_SPLIT_NO_EMPTY);
  $ok = $b && in_array("promo-card", $parts, TRUE) && in_array("is-highlighted", $parts, TRUE);
  print ($ok ? "PASS" : "FAIL") . " block_class=" . var_export($v, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
