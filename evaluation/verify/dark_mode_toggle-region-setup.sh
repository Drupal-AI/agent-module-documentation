#!/usr/bin/env bash
# Introspection SETUP: place the Dark Mode Toggle block in the olivero 'sidebar' region as
# block.block.dmt_eval_known so an inspecting agent can read back its region. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if (!Block::load("dmt_eval_known")) {
    Block::create([
      "id" => "dmt_eval_known", "theme" => "olivero", "region" => "sidebar",
      "plugin" => "dark_mode_toggle", "weight" => 0,
      "settings" => ["id" => "dark_mode_toggle", "label" => "Dark Mode Toggle", "label_display" => "0"],
      "visibility" => [],
    ])->save();
  } else {
    $b = Block::load("dmt_eval_known"); $b->setRegion("sidebar"); $b->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block dmt_eval_known (plugin dark_mode_toggle) placed in olivero region 'sidebar'"
