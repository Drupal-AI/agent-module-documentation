#!/usr/bin/env bash
# Introspection SETUP: create a minimal View (vjs_known) that uses the Views JSON Source query
# backend with a known row_apath, so an agent can read the apath back from the view config.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vjs_known")) { $v->delete(); }
  View::create([
    "id" => "vjs_known", "label" => "VJS Known", "base_table" => "json", "status" => TRUE,
    "display" => [
      "default" => [
        "display_plugin" => "default", "id" => "default", "display_title" => "Master", "position" => 0,
        "display_options" => [
          "query" => ["type" => "views_json_source_query", "options" => [
            "json_file" => "https://example.com/known.json",
            "row_apath" => "data/records",
            "request_method" => "get",
            "show_errors" => 1,
          ]],
          "fields" => [
            "value" => ["id" => "value", "table" => "json", "field" => "value",
                        "plugin_id" => "views_json_source_field", "key" => "title"],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vjs_known created (query row_apath=data/records)"
