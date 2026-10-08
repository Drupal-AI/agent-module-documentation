#!/usr/bin/env bash
# Introspection SETUP: create a view "paragraphs_admin_intro" on the paragraphs base table that
# includes the paragraphs_admin "Host Entity" (paragraphs_host_entity) Views field, so an agent
# can inspect which paragraphs_admin field the view uses. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("paragraphs_admin_intro")) { $v->delete(); }
  View::create([
    "id" => "paragraphs_admin_intro",
    "label" => "Paragraphs Admin Intro",
    "base_table" => "paragraphs_item_field_data",
    "base_field" => "id",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "fields" => [
            "paragraphs_host_entity" => [
              "id" => "paragraphs_host_entity",
              "table" => "paragraphs_item_field_data",
              "field" => "paragraphs_host_entity",
              "plugin_id" => "paragraphs_host_entity",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: views.view.paragraphs_admin_intro includes field paragraphs_host_entity"
