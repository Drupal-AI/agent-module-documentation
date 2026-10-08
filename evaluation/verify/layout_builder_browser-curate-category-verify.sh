#!/usr/bin/env bash
# Execution VERIFY for "curate a Layout Builder Browser category".
# PASS when: a layout_builder_browser_blockcat "lbb_task_hero" exists, is enabled, labelled
# "LBB Task Hero", and at least one ENABLED layout_builder_browser_block in that category has
# block_id = system_powered_by_block. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $cat = \Drupal::entityTypeManager()->getStorage("layout_builder_browser_blockcat")->load("lbb_task_hero");
  $catOk = $cat && $cat->status() && $cat->label() === "LBB Task Hero";
  $blocks = \Drupal::entityTypeManager()->getStorage("layout_builder_browser_block")
    ->loadByProperties(["category" => "lbb_task_hero", "status" => TRUE]);
  $ids = [];
  $blockOk = FALSE;
  foreach ($blocks as $b) {
    $ids[] = $b->id() . "=" . $b->block_id;
    if ($b->block_id === "system_powered_by_block") { $blockOk = TRUE; }
  }
  $ok = $catOk && $blockOk;
  print ($ok ? "PASS" : "FAIL")
    . " cat=" . ($cat ? ($cat->label() . "/status=" . (int) $cat->status()) : "missing")
    . " blocks=[" . implode(",", $ids) . "]\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
