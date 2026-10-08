#!/usr/bin/env bash
# Introspection SETUP: place a block (routecond_known) in olivero whose Route condition
# restricts it to a known route name, so an inspecting agent can read it back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("routecond_known")) { $b->delete(); }
  Block::create([
    "id" => "routecond_known", "theme" => "olivero", "region" => "content",
    "plugin" => "system_powered_by_block",
    "settings" => ["id" => "system_powered_by_block", "label" => "RC Known", "label_display" => "0"],
    "visibility" => ["route" => ["id" => "route", "negate" => FALSE, "routes" => "entity.user.canonical"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block routecond_known restricted via route condition to entity.user.canonical"
