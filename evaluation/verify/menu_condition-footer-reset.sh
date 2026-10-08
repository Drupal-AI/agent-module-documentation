#!/usr/bin/env bash
# Execution RESET: (re)create block mc_footer with NO visibility conditions, so verify FAILS
# until the agent adds a menu_position condition on the footer menu. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("mc_footer")) { $b->delete(); }
  Block::create([
    "id" => "mc_footer", "theme" => "olivero", "region" => "content",
    "plugin" => "system_powered_by_block",
    "settings" => ["id" => "system_powered_by_block", "label" => "MC Footer", "label_display" => "0"],
    "visibility" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block mc_footer present with no visibility conditions"
