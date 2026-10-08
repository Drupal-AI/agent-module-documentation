#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution RESET for the "build a DEPENDENT (cascading) entityreference_filter" task.
# Clears the target view `eval_erf_dep` and ensures the reusable Entity Reference reference
# view `eval_erf_src:entity_reference_1` (base: nodes) exists. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $storage->load("eval_erf_dep")) { $v->delete(); }
  if (!$storage->load("eval_erf_src")) {
    $storage->create([
      "id" => "eval_erf_src",
      "label" => "Eval ERF Source (reference)",
      "base_table" => "node_field_data",
      "base_field" => "nid",
      "display" => [
        "default" => [
          "display_plugin" => "default",
          "id" => "default",
          "display_title" => "Default",
          "position" => 0,
          "display_options" => ["style" => ["type" => "entity_reference"], "row" => ["type" => "entity_reference"]],
        ],
        "entity_reference_1" => [
          "display_plugin" => "entity_reference",
          "id" => "entity_reference_1",
          "display_title" => "Entity Reference",
          "position" => 1,
          "display_options" => [],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: eval_erf_dep cleared; reference view eval_erf_src:entity_reference_1 ensured"
