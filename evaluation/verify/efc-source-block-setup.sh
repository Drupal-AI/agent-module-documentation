#!/usr/bin/env bash
# Introspection SETUP: place block efc_source_block whose node_field condition uses the
# "contains" value source on the Article title, so an agent can read back which value source
# (comparison mode) is configured. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("efc_source_block")) { $b->delete(); }
  Block::create([
    "id" => "efc_source_block", "theme" => $theme, "region" => "content",
    "plugin" => "system_powered_by_block", "weight" => -49,
    "settings" => ["id" => "system_powered_by_block", "label" => "EFC Source", "label_display" => "0"],
    "visibility" => [
      "node_field" => [
        "id" => "node_field", "negate" => FALSE,
        "context_mapping" => ["node" => "@node.node_route_context:node"],
        "entity_type_id" => "node", "entity_bundle" => "", 
        "field" => "title", "value_source" => "contains", "value" => "news",
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block efc_source_block node_field value_source=contains (title contains 'news')"
