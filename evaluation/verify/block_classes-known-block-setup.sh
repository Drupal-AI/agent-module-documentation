#!/usr/bin/env bash
# Introspection SETUP: place a block (block_classes_known) in the default theme and give it
# known Block Classes third-party settings, so an inspecting agent can read them back from the
# live block config entity. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("block_classes_known")) { $b->delete(); }
  Block::create([
    "id" => "block_classes_known",
    "plugin" => "system_powered_by_block",
    "theme" => $theme,
    "region" => "content",
    "weight" => 90,
    "settings" => [
      "id" => "system_powered_by_block",
      "label" => "BC Known Block",
      "label_display" => "visible",
      "provider" => "system",
    ],
    "third_party_settings" => [
      "block_classes" => [
        "block_class" => "bc-known-wrapper",
        "title_class" => "bc-known-title",
      ],
    ],
  ])->save();
' >/dev/null 2>&1
echo "setup: block_classes_known placed with block_class=bc-known-wrapper title_class=bc-known-title"
