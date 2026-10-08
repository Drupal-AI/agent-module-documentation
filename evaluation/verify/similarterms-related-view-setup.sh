#!/usr/bin/env bash
# Introspection SETUP: create a node view "st_related" using the similarterms handlers with known
# options — a "Similar by terms: Nid" contextual filter (similar_terms_arg) with
# min_match_percentage=75, and a "Similar by terms: Similarity" field (similar_terms_field) set to
# display the SUM OF TERM WEIGHTS (count_type=2). Lets an agent read those options back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("st_related")) {
    View::create([
      "id" => "st_related",
      "label" => "ST related",
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
              "similarterms" => [
                "id" => "similarterms",
                "table" => "node",
                "field" => "similarterms",
                "plugin_id" => "similar_terms_field",
                "count_type" => 2,
                "percent_suffix" => 1,
                "weight_suffix" => " pts",
              ],
            ],
            "arguments" => [
              "similar_nid" => [
                "id" => "similar_nid",
                "table" => "node",
                "field" => "similar_nid",
                "plugin_id" => "similar_terms_arg",
                "default_action" => "ignore",
                "vocabularies" => [],
                "include_args" => FALSE,
                "min_match_percentage" => 75,
              ],
            ],
          ],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view st_related similar_nid min_match_percentage=75; similarterms field count_type=2 (weights)"
