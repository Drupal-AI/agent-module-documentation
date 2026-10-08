#!/usr/bin/env bash
# Introspection SETUP: create a view "vat_raw" whose contextual filter uses the token default
# plugin with RAW field values ON (process=1) and AND joining (and_or=","), token
# [node:field_tags]. Lets the agent read those options back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("vat_raw")) {
    View::create([
      "id" => "vat_raw",
      "label" => "VAT raw",
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
                "default_argument_type" => "token",
                "default_argument_options" => [
                  "argument" => "[node:field_tags]",
                  "process" => 1,
                  "and_or" => ",",
                  "all_option" => 0,
                  "debug" => 0,
                ],
              ],
            ],
          ],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vat_raw token argument process=1 (raw) and_or=, (AND) argument=[node:field_tags]"
