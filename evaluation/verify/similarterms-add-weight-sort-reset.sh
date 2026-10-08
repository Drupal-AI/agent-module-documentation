#!/usr/bin/env bash
# Execution RESET: (re)create node view "st_sort" that already has the "Similar by terms: Nid"
# argument but NO similarity sort, so verify FAILS until the agent adds the
# "Similar by terms: Similarity" sort (similar_terms_sort) configured to sort by SUM OF TERM
# WEIGHTS (sort_method="weight"). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("st_sort")) { $v->delete(); }
  View::create([
    "id" => "st_sort",
    "label" => "ST sort",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "arguments" => [
            "similar_nid" => [
              "id" => "similar_nid",
              "table" => "node",
              "field" => "similar_nid",
              "plugin_id" => "similar_terms_arg",
              "default_action" => "ignore",
              "vocabularies" => [],
              "include_args" => FALSE,
              "min_match_percentage" => 0,
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view st_sort has similar_nid argument but no similarity sort yet"
