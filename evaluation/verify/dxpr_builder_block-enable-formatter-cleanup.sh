#!/usr/bin/env bash
# Execution CLEANUP: restore the drag_and_drop_block body view display to its shipped DXPR
# Builder formatter (dxpr_builder_text). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("block_content.drag_and_drop_block.default");
  if ($vd) {
    $vd->setComponent("body", ["type" => "dxpr_builder_text", "label" => "hidden", "weight" => 0, "region" => "content"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: block_content.drag_and_drop_block.default body formatter restored to dxpr_builder_text"
