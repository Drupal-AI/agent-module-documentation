#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: build a KNOWN view `eval_vttnd_known` on the node base table that
# uses this module's "term name (with depth)" contextual filter at DEPTH 3, so the agent
# can inspect the live config and report the depth. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("eval_vttnd_known")) { $v->delete(); }
  $view = \Drupal\views\Entity\View::create([
    "id" => "eval_vttnd_known",
    "label" => "Eval VTTND Known",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "display_options" => [
          "arguments" => [
            "term_node_taxonomy_name_depth" => [
              "id" => "term_node_taxonomy_name_depth",
              "table" => "node_field_data",
              "field" => "term_node_taxonomy_name_depth",
              "plugin_id" => "taxonomy_index_name_depth",
              "depth" => "3",
              "break_phrase" => FALSE,
              "vocabularies" => [],
            ],
          ],
        ],
      ],
    ],
  ]);
  $view->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view eval_vttnd_known created with taxonomy_index_name_depth argument at depth 3"
