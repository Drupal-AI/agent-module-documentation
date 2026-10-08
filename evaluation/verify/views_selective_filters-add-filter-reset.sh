#!/usr/bin/env bash
# Execution RESET: (re)create a plain view "vsf_eval_hard" with NO selective filter, so verify
# FAILS until the agent adds a views_selective_filters_filter to it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $s->load("vsf_eval_hard")) { $v->delete(); }
  $s->create([
    "id" => "vsf_eval_hard",
    "label" => "VSF Eval Hard",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "id" => "default",
        "display_plugin" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => ["filters" => []],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
echo "reset: view vsf_eval_hard exists with no selective filter"
