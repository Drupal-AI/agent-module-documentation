#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: build a KNOWN view `eval_vyf_known` on the node base table whose
# "Authored on" (created) date filter is set to Views Year Filter's YEAR mode
# (value.type = date_year) for the year 2019, so the agent can inspect the live view
# config and report the configured year. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if ($v = \Drupal::entityTypeManager()->getStorage("view")->load("eval_vyf_known")) { $v->delete(); }
  $view = \Drupal\views\Entity\View::create([
    "id" => "eval_vyf_known",
    "label" => "Eval VYF Known",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "display_options" => [
          "filters" => [
            "created" => [
              "id" => "created",
              "table" => "node_field_data",
              "field" => "created",
              "plugin_id" => "date",
              "operator" => "=",
              "value" => [
                "type" => "date_year",
                "value" => "2019",
                "min" => "",
                "max" => "",
              ],
            ],
          ],
        ],
      ],
    ],
  ]);
  $view->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view eval_vyf_known created with created date filter in date_year mode = 2019"
