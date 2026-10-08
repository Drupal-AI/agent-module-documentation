#!/usr/bin/env bash
# Execution VERIFY: PASS when efc_task_block has a node_field visibility condition targeting
# the Article title with an exact ("specified") match on value "Task Passed". exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\block\Entity\Block;
  $b = Block::load("efc_task_block");
  $v = $b ? ($b->get("visibility")["node_field"] ?? NULL) : NULL;
  $ok = $v
    && ($v["id"] ?? "") === "node_field"
    && ($v["field"] ?? "") === "title"
    && ($v["value_source"] ?? "") === "specified"
    && ($v["value"] ?? "") === "Task Passed";
  print ($ok ? "PASS" : "FAIL")
    . " field=" . ($v["field"] ?? "none")
    . " source=" . ($v["value_source"] ?? "none")
    . " value=" . ($v["value"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
