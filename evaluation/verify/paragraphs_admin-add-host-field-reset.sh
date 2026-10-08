#!/usr/bin/env bash
# Execution RESET: (re)create a view "paragraphs_admin_task" on the paragraphs base table with
# only a plain id field and NO paragraphs_host_entity field, so verify FAILS until the agent
# adds the paragraphs_admin "Host Entity" Views field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("paragraphs_admin_task")) { $v->delete(); }
  View::create([
    "id" => "paragraphs_admin_task",
    "label" => "Paragraphs Admin Task",
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
            "id" => ["id"=>"id","table"=>"paragraphs_item_field_data","field"=>"id","plugin_id"=>"field"],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views.view.paragraphs_admin_task has NO paragraphs_host_entity field"
