#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: install a KNOWN Content View `eval_intro_erf_ref` whose exposed
# entityreference_filter is wired to a SPECIFIC reference view display,
# reference_display = "curated_terms:entity_reference_1". An inspecting agent reads the view
# config back via drush to report which reference view/display supplies the filter options.
# Idempotent: deletes any prior copy first. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $id = "eval_intro_erf_ref";
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $storage->load($id)) { $v->delete(); }
  $filter = [
    "id" => "nid_entityreference_filter",
    "table" => "node_field_data",
    "field" => "nid_entityreference_filter",
    "plugin_id" => "entityreference_filter_view_result",
    "entity_type" => "node",
    "operator" => "in",
    "value" => [],
    "type" => "select",
    "reference_display" => "curated_terms:entity_reference_1",
    "reference_arguments" => "",
    "hide_empty_filter" => TRUE,
    "exposed" => TRUE,
    "expose" => [
      "operator_id" => "nid_entityreference_filter_op",
      "label" => "Reference filter",
      "identifier" => "ref",
      "multiple" => FALSE,
      "required" => FALSE,
    ],
  ];
  $storage->create([
    "id" => $id,
    "label" => "Eval Intro ERF Ref",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "filters" => ["nid_entityreference_filter" => $filter],
          "pager" => ["type" => "full"],
        ],
      ],
      "page_1" => [
        "display_plugin" => "page",
        "id" => "page_1",
        "display_title" => "Page",
        "position" => 1,
        "display_options" => ["path" => "eval-intro-erf-ref"],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view eval_intro_erf_ref installed (reference_display=curated_terms:entity_reference_1)"
