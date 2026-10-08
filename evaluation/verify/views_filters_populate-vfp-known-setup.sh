#!/usr/bin/env bash
# Introspection SETUP: create a namespaced view vfp_known whose default display has a
# non-exposed string filter (title_target) plus an exposed views_filters_populate filter
# (populate) targeting it, so an inspecting agent can read back the plugin/target wiring
# via drush. Config-only (not required to execute/render). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
$data = [
  "langcode" => "en",
  "status" => TRUE,
  "dependencies" => ["module" => ["node", "views_filters_populate"]],
  "id" => "vfp_known",
  "label" => "VFP Known",
  "module" => "views",
  "description" => "",
  "tag" => "",
  "base_table" => "node_field_data",
  "base_field" => "nid",
  "display" => [
    "default" => [
      "id" => "default",
      "display_title" => "Default",
      "display_plugin" => "default",
      "position" => 0,
      "display_options" => [
        "title" => "VFP Known",
        "fields" => [
          "title" => [
            "id" => "title", "table" => "node_field_data", "field" => "title",
            "relationship" => "none", "group_type" => "group", "admin_label" => "",
            "entity_type" => "node", "entity_field" => "title", "plugin_id" => "field",
            "label" => "Title", "exclude" => FALSE,
            "alter" => ["alter_text" => FALSE], "element_class" => "",
            "element_default_classes" => TRUE, "empty" => "", "hide_empty" => FALSE,
            "empty_zero" => FALSE, "hide_alter_empty" => TRUE,
            "type" => "string", "settings" => ["link_to_entity" => TRUE],
          ],
        ],
        "pager" => ["type" => "some", "options" => ["offset" => 0, "items_per_page" => 10]],
        "exposed_form" => ["type" => "basic", "options" => [
          "submit_button" => "Apply", "reset_button" => FALSE, "reset_button_label" => "Reset",
          "exposed_sorts_label" => "Sort by", "expose_sort_order" => TRUE,
          "sort_asc_label" => "Asc", "sort_desc_label" => "Desc",
        ]],
        "access" => ["type" => "perm", "options" => ["perm" => "access content"]],
        "cache" => ["type" => "tag", "options" => []],
        "empty" => [],
        "sorts" => [],
        "arguments" => [],
        "filters" => [
          "title_target" => [
            "id" => "title_target", "table" => "node_field_data", "field" => "title",
            "relationship" => "none", "group_type" => "group", "admin_label" => "",
            "entity_type" => "node", "entity_field" => "title",
            "plugin_id" => "string", "operator" => "contains", "value" => "",
            "group" => 1, "exposed" => FALSE,
            "expose" => [
              "operator_id" => "", "label" => "", "description" => "", "use_operator" => FALSE,
              "operator" => "", "operator_limit_selection" => FALSE, "operator_list" => [],
              "identifier" => "", "required" => FALSE, "remember" => FALSE, "multiple" => FALSE,
            ],
            "is_grouped" => FALSE,
            "group_info" => [
              "label" => "", "description" => "", "identifier" => "", "optional" => TRUE,
              "widget" => "select", "multiple" => FALSE, "remember" => FALSE,
              "default_group" => "All", "default_group_multiple" => [], "group_items" => [],
            ],
          ],
          "populate" => [
            "id" => "populate", "table" => "views_filters_populate", "field" => "populate",
            "relationship" => "none", "group_type" => "group", "admin_label" => "",
            "plugin_id" => "views_filters_populate", "operator" => "=", "value" => "",
            "group" => 1, "exposed" => TRUE,
            "expose" => [
              "operator_id" => "", "label" => "Populate filters", "description" => "",
              "use_operator" => FALSE, "operator" => "populate_op",
              "operator_limit_selection" => FALSE, "operator_list" => [],
              "identifier" => "populate", "required" => FALSE, "remember" => FALSE,
              "multiple" => FALSE,
            ],
            "is_grouped" => FALSE,
            "group_info" => [
              "label" => "", "description" => "", "identifier" => "", "optional" => TRUE,
              "widget" => "select", "multiple" => FALSE, "remember" => FALSE,
              "default_group" => "All", "default_group_multiple" => [], "group_items" => [],
            ],
            "filters" => ["title_target" => "title_target"],
          ],
        ],
        "filter_groups" => ["operator" => "AND", "groups" => [1 => "AND"]],
        "style" => ["type" => "default"],
        "row" => ["type" => "fields"],
        "query" => ["type" => "views_query", "options" => [
          "query_comment" => "", "disable_sql_rewrite" => FALSE, "distinct" => FALSE,
          "replica" => FALSE, "query_tags" => [],
        ]],
        "relationships" => [],
        "header" => [],
        "footer" => [],
        "display_extenders" => [],
      ],
    ],
  ],
];
\Drupal::configFactory()->getEditable("views.view.vfp_known")->setData($data)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: views.view.vfp_known created (populate -> title_target)"
