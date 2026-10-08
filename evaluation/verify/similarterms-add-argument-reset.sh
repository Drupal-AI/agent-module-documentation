#!/usr/bin/env bash
# Execution RESET: (re)create node view "st_task" with NO similarterms contextual filter, so
# verify FAILS until the agent adds the "Similar by terms: Nid" argument (similar_terms_arg) with
# min_match_percentage=50. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("st_task")) { $v->delete(); }
  View::create([
    "id" => "st_task",
    "label" => "ST task",
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
            "title" => [
              "id" => "title",
              "table" => "node_field_data",
              "field" => "title",
              "plugin_id" => "field",
              "entity_type" => "node",
              "entity_field" => "title",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view st_task has no similarterms argument yet"
