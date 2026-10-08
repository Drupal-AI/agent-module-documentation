#!/usr/bin/env bash
# Introspection SETUP: save two competing theme_switcher rules that both match /ts-order, with
# different weights, so the agent has to work out which one wins on the live site. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\theme_switcher\Entity\ThemeSwitcherRule;
  $rules = [
    ["ts_order_alpha", "TS order alpha", -5, "olivero"],
    ["ts_order_beta", "TS order beta", 7, "claro"],
  ];
  foreach ($rules as [$id, $label, $weight, $theme]) {
    $r = ThemeSwitcherRule::load($id) ?: ThemeSwitcherRule::create(["id" => $id]);
    $r->set("label", $label)
      ->set("status", TRUE)
      ->set("weight", $weight)
      ->set("theme", $theme)
      ->set("admin_theme", "")
      ->set("conjunction", "and")
      ->set("visibility", [
        "request_path" => [
          "id" => "request_path", "negate" => FALSE, "context_mapping" => [],
          "pages" => "/ts-order\n/ts-order/*",
        ],
      ])
      ->save();
  }
' >/dev/null 2>&1
echo "setup: ts_order_alpha (weight -5, olivero) and ts_order_beta (weight 7, claro) both match /ts-order"
