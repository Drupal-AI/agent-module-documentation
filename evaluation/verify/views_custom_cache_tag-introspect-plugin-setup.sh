#!/usr/bin/env bash
# Introspection SETUP: create a known View (vcct_eval_plugin) whose default display uses a
# views cache plugin with the custom cache tag `eval:catalog`. The agent must inspect the
# running site and identify WHICH cache plugin the view uses (id custom_tag). Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($existing = $storage->load("vcct_eval_plugin")) { $existing->delete(); }
  $storage->create([
    "id" => "vcct_eval_plugin",
    "label" => "VCCT Eval Plugin",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "cache" => [
            "type" => "custom_tag",
            "options" => [
              "custom_tag" => "eval:catalog",
              "custom_tag_output_lifespan" => "3600",
              "custom_tag_output_lifespan_expression" => "",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vcct_eval_plugin created using the custom_tag cache plugin (tag: eval:catalog)"
