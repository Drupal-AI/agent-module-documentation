#!/usr/bin/env bash
# Introspection SETUP: create a known node view (id: st_eval_mode) whose Select translation
# Views filter is configured in CUSTOM LIST mode with the language priority list
# "fr,en,current" so an inspecting agent can read the mode + priorities back out of the
# view config. Idempotent (recreates the view). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $storage->load("st_eval_mode")) { $v->delete(); }
  $storage->create([
    "id" => "st_eval_mode",
    "label" => "ST Eval Mode",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "filters" => [
            "select_translation" => [
              "id" => "select_translation",
              "table" => "node_field_data",
              "field" => "select_translation",
              "plugin_id" => "select_translation_filter",
              "value" => "list",
              "priorities" => "fr,en,current",
              "default_language_only" => 0,
              "include_content_with_unpublished_translation" => 0,
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view st_eval_mode with select_translation_filter value=list priorities=fr,en,current"
