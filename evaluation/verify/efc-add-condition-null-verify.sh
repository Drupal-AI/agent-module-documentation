#!/usr/bin/env bash
# Execution VERIFY (null variant): PASS when efc_task_block has a node_field visibility
# condition on the Article title using value_source "null" (Is NULL). exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("efc_task_block");
  $v = $b ? ($b->get("visibility")["node_field"] ?? NULL) : NULL;
  $ok = $v
    && ($v["id"] ?? "") === "node_field"
    && ($v["field"] ?? "") === "title"
    && ($v["value_source"] ?? "") === "null";
  print ($ok ? "PASS" : "FAIL")
    . " field=" . ($v["field"] ?? "none")
    . " source=" . ($v["value_source"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
