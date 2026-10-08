#!/usr/bin/env bash
# Execution RESET: ensure a namespaced block blocache_task exists WITHOUT any blocache override, so
# verify FAILS until the agent overrides its cache. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("blocache_task")) { $b->delete(); }
  $b = Block::create([
    "id" => "blocache_task", "theme" => "olivero", "region" => "content",
    "plugin" => "system_powered_by_block",
    "settings" => ["id" => "system_powered_by_block", "label" => "Blocache Task", "label_display" => "0"],
  ]);
  $b->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block blocache_task present with no blocache override"
