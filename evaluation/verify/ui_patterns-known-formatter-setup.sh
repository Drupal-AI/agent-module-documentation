#!/usr/bin/env bash
# introspection setup: point the Article default display's body field at a UI Patterns
# per-item component formatter rendering a known SDC component.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default")
    ->setComponent("body", [
      "type" => "ui_patterns_component_per_item", "label" => "hidden", "weight" => 1, "region" => "content",
      "settings" => ["ui_patterns" => [
        "component_id" => "olivero:teaser", "variant_id" => "", "props" => [],
        "slots" => ["content" => ["sources" => [[
          "source_id" => "textfield", "source" => ["value" => "Eval body"], "value" => "Eval body"]]]],
      ]],
    ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article body uses ui_patterns_component_per_item -> olivero:teaser"
