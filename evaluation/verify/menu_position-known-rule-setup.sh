#!/usr/bin/env bash
# Introspection SETUP: create two menu_position_rule config entities — mp_intro_a (ENABLED,
# matches the Article content type via the core entity_bundle:node condition) and mp_intro_b
# (DISABLED, matches Basic page) — both in the main menu under the Home link. The agent must
# read the live rule config to say which one is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\menu_position\Entity\MenuPositionRule;
  $spec = [
    "mp_intro_a" => ["label" => "MP Intro A", "enabled" => TRUE, "bundle" => "article", "weight" => 0],
    "mp_intro_b" => ["label" => "MP Intro B", "enabled" => FALSE, "bundle" => "page", "weight" => 1],
  ];
  $storage = \Drupal::entityTypeManager()->getStorage("menu_position_rule");
  foreach ($spec as $id => $s) {
    if ($existing = $storage->load($id)) { $existing->delete(); }
    MenuPositionRule::create([
      "id" => $id,
      "label" => $s["label"],
      "enabled" => $s["enabled"],
      "menu_name" => "main",
      "parent" => "standard.front_page",
      "menu_link" => "menu_position_link:" . $id,
      "weight" => $s["weight"],
      "conditions" => [
        "entity_bundle:node" => [
          "id" => "entity_bundle:node",
          "negate" => FALSE,
          "context_mapping" => ["node" => "@node.node_route_context:node"],
          "bundles" => [$s["bundle"] => $s["bundle"]],
        ],
      ],
    ])->save();
    print $id . " enabled=" . var_export($s["enabled"], TRUE) . " bundle=" . $s["bundle"] . "\n";
  }
  \Drupal::service("plugin.manager.menu.link")->rebuild();
' 2>/dev/null
echo "setup: mp_intro_a enabled (article), mp_intro_b disabled (page)"
