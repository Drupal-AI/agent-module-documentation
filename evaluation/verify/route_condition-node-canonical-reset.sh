#!/usr/bin/env bash
# Execution RESET: place a block (routecond_task) in olivero with an EMPTY Route condition
# (routes = "" => matches everywhere), so verify FAILS until the agent restricts it to the
# node canonical route. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("routecond_task")) { $b->delete(); }
  Block::create([
    "id" => "routecond_task", "theme" => "olivero", "region" => "content",
    "plugin" => "system_powered_by_block",
    "settings" => ["id" => "system_powered_by_block", "label" => "RC Task", "label_display" => "0"],
    "visibility" => ["route" => ["id" => "route", "negate" => FALSE, "routes" => ""]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block routecond_task present with empty route condition (matches everywhere)"
