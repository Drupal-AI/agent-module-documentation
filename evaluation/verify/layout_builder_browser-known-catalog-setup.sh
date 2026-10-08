#!/usr/bin/env bash
# Introspection SETUP: build a small curated catalog — category lbb_eval_cat holding two
# browser blocks (lbb_eval_powered enabled, lbb_eval_help DISABLED) — so an inspecting agent
# must read the live layout_builder_browser_block / _blockcat config entities to answer.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $catStorage = \Drupal::entityTypeManager()->getStorage("layout_builder_browser_blockcat");
  $blkStorage = \Drupal::entityTypeManager()->getStorage("layout_builder_browser_block");
  if ($e = $catStorage->load("lbb_eval_cat")) { $e->delete(); }
  foreach (["lbb_eval_powered", "lbb_eval_help"] as $id) {
    if ($e = $blkStorage->load($id)) { $e->delete(); }
  }
  $catStorage->create([
    "id" => "lbb_eval_cat", "label" => "LBB Eval Promotions", "status" => TRUE,
    "weight" => 7, "opened" => FALSE, "image_path" => "", "image_alt" => "",
  ])->save();
  $blkStorage->create([
    "id" => "lbb_eval_powered", "block_id" => "system_powered_by_block",
    "category" => "lbb_eval_cat", "label" => "LBB Eval Powered Badge",
    "status" => TRUE, "weight" => 0, "image_path" => "", "image_alt" => "",
  ])->save();
  $blkStorage->create([
    "id" => "lbb_eval_help", "block_id" => "help_block",
    "category" => "lbb_eval_cat", "label" => "LBB Eval Help",
    "status" => FALSE, "weight" => 1, "image_path" => "", "image_alt" => "",
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: lbb_eval_cat (opened=FALSE, weight=7) with lbb_eval_powered=enabled, lbb_eval_help=disabled"
