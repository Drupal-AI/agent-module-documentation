#!/usr/bin/env bash
# Introspection SETUP: place a block (routecond_neg) whose Route condition uses a wildcard
# and a tilde exclusion, so an agent can read the wildcard/exclusion syntax back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  if ($b = Block::load("routecond_neg")) { $b->delete(); }
  Block::create([
    "id" => "routecond_neg", "theme" => "olivero", "region" => "content",
    "plugin" => "system_powered_by_block",
    "settings" => ["id" => "system_powered_by_block", "label" => "RC Neg", "label_display" => "0"],
    "visibility" => ["route" => ["id" => "route", "negate" => FALSE, "routes" => "entity.node.*\n~entity.node.edit_form"]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block routecond_neg route condition routes = entity.node.* and ~entity.node.edit_form"
