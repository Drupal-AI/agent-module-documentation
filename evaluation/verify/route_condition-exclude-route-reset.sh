#!/usr/bin/env bash
# Execution RESET: place a block (routecond_excl) whose Route condition matches everywhere
# with NO exclusion, so verify FAILS until the agent adds a tilde exclusion for the user
# login route. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("routecond_excl")) { $b->delete(); }
  Block::create([
    "id" => "routecond_excl", "theme" => "olivero", "region" => "content",
    "plugin" => "system_powered_by_block",
    "settings" => ["id" => "system_powered_by_block", "label" => "RC Excl", "label_display" => "0"],
    "visibility" => ["route" => ["id" => "route", "negate" => FALSE, "routes" => "entity.node.canonical"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: block routecond_excl present without a ~user.login exclusion"
