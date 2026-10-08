#!/usr/bin/env bash
# Execution RESET: (re)create the main-menu block barl_task_menu in Olivero with NO
# block_aria_landmark_roles third-party settings, so verify fails until the agent adds them.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("barl_task_menu")) { $b->delete(); }
  Block::create([
    "id" => "barl_task_menu", "theme" => "olivero", "region" => "sidebar", "weight" => 25,
    "plugin" => "system_menu_block:main",
    "settings" => [
      "id" => "system_menu_block:main", "label" => "BARL task menu",
      "label_display" => "visible", "provider" => "system",
      "level" => 1, "depth" => 0, "expand_all_items" => FALSE,
    ],
    "visibility" => [],
  ])->save();
  $b = Block::load("barl_task_menu");
  print "reset: barl_task_menu role=" . var_export($b->getThirdPartySetting("block_aria_landmark_roles", "role"), TRUE) . "\n";
' 2>/dev/null
drush cr >/dev/null 2>&1
exit 0
