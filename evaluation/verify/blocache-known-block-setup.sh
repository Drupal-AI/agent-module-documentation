#!/usr/bin/env bash
# Introspection SETUP: create a namespaced block (blocache_eval) and use blocache to override its
# cacheability with a distinctive max-age (137s), so an inspecting agent can read the value back from
# the live block config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("blocache_eval")) { $b->delete(); }
  $b = Block::create([
    "id" => "blocache_eval", "theme" => "olivero", "region" => "content",
    "plugin" => "system_powered_by_block",
    "settings" => ["id" => "system_powered_by_block", "label" => "Blocache Eval", "label_display" => "0"],
  ]);
  $b->setThirdPartySetting("blocache", "overridden", TRUE);
  $b->setThirdPartySetting("blocache", "metadata", ["max-age" => 137, "contexts" => [], "tags" => []]);
  $b->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block blocache_eval has blocache override max-age=137"
