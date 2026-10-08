#!/usr/bin/env bash
# Introspection SETUP: place a block (efc_known_block) carrying an entity_field_condition
# node_field visibility condition (Article title === "EFC Target Value"), so an inspecting
# agent can read the configured field/value from the block config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("efc_known_block")) { $b->delete(); }
  Block::create([
    "id" => "efc_known_block", "theme" => $theme, "region" => "content",
    "plugin" => "system_powered_by_block", "weight" => -50,
    "settings" => ["id" => "system_powered_by_block", "label" => "EFC Known", "label_display" => "0"],
    "visibility" => [
      "node_field" => [
        "id" => "node_field", "negate" => FALSE,
        "context_mapping" => ["node" => "@node.node_route_context:node"],
        "entity_type_id" => "node", "entity_bundle" => "article",
        "field" => "title", "value_source" => "specified", "value" => "EFC Target Value",
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block efc_known_block has node_field condition (title === 'EFC Target Value')"
