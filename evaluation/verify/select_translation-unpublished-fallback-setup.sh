#!/usr/bin/env bash
# Introspection SETUP: create a known node view (id: st_eval_unpub) whose Select translation
# Views filter has the "return default-language content when the current-language translation
# is unpublished" option ENABLED (include_content_with_unpublished_translation = 1), with the
# base selection mode left at "default". An inspecting agent must read this flag off the view
# config. Idempotent (recreates the view). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $storage->load("st_eval_unpub")) { $v->delete(); }
  $storage->create([
    "id" => "st_eval_unpub",
    "label" => "ST Eval Unpub",
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
              "value" => "default",
              "priorities" => "",
              "default_language_only" => 0,
              "include_content_with_unpublished_translation" => 1,
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view st_eval_unpub with include_content_with_unpublished_translation=1 (mode default)"
