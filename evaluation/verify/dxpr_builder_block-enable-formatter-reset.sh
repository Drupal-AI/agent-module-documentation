#!/usr/bin/env bash
# Execution RESET: force the body component of the drag_and_drop_block default view display to
# the plain 'text_default' formatter (NOT DXPR Builder), so verify FAILS until the agent switches
# it to dxpr_builder_text. Ensures the submodule is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush en dxpr_builder_block -y >/dev/null 2>&1
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("block_content.drag_and_drop_block.default");
  if ($vd) {
    $vd->setComponent("body", ["type" => "text_default", "label" => "hidden", "weight" => 0, "region" => "content"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block_content.drag_and_drop_block.default body formatter = text_default (not DXPR)"
