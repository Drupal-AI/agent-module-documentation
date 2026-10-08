#!/usr/bin/env bash
# Execution RESET: (re)create view "views_base_url_task" with only a title field and NO base_url
# field, so verify FAILS until the agent adds the Global: Base url (base_url) Views field.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("views_base_url_task")) { $v->delete(); }
  View::create([
    "id" => "views_base_url_task",
    "label" => "Views Base URL Task",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "fields" => [
            "title" => ["id"=>"title","table"=>"node_field_data","field"=>"title","plugin_id"=>"field"],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: views.view.views_base_url_task has NO base_url field"
