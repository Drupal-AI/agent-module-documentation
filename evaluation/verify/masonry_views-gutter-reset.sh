#!/usr/bin/env bash
# Execution RESET: create/reset a view that already uses the Masonry style but with gutterWidth
# at the default '0', so a "set the gutter to 20" task fails until performed. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("masonry_views_gutter")) { $v->delete(); }
  View::create([
    "id" => "masonry_views_gutter", "label" => "Masonry Views Gutter",
    "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "row" => ["type" => "entity:node"],
        "style" => ["type" => "masonry", "options" => ["gutterWidth" => "0"]],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view masonry_views_gutter uses masonry style with gutterWidth=0"
