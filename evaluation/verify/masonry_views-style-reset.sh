#!/usr/bin/env bash
# Execution RESET: create/reset a view whose default display uses the plain 'default' (unformatted)
# style, so verify fails until the agent switches its Format to Masonry. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("masonry_views_task")) { $v->delete(); }
  View::create([
    "id" => "masonry_views_task", "label" => "Masonry Views Task",
    "base_table" => "node_field_data",
    "display" => ["default" => [
      "display_plugin" => "default", "id" => "default", "display_title" => "Default", "position" => 0,
      "display_options" => [
        "row" => ["type" => "entity:node"],
        "style" => ["type" => "default", "options" => []],
      ],
    ]],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view masonry_views_task uses style=default (not masonry)"
