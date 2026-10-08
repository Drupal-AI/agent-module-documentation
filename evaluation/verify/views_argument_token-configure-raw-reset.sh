#!/usr/bin/env bash
# Execution RESET: (re)create node view "vat_rawtask" with a nid contextual filter defaulting to
# a FIXED value, so verify FAILS until the agent switches it to the views_argument_token "token"
# plugin with [node:field_tags] and RAW field values on (process=1). Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("vat_rawtask")) { $v->delete(); }
  View::create([
    "id" => "vat_rawtask",
    "label" => "VAT raw task",
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
            "nid" => [
              "id" => "nid",
              "table" => "node_field_data",
              "field" => "nid",
              "plugin_id" => "numeric",
              "entity_type" => "node",
              "entity_field" => "nid",
              "default_action" => "default",
              "default_argument_type" => "fixed",
              "default_argument_options" => ["argument" => "1"],
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vat_rawtask nid argument default_argument_type=fixed (token not yet used)"
