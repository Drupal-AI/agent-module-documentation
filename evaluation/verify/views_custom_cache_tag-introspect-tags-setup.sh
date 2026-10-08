#!/usr/bin/env bash
# Introspection SETUP: create a known View (vcct_eval_tags) whose default display uses the
# views_custom_cache_tag `custom_tag` cache plugin with two KNOWN custom cache tags
# (eval:report and eval:widgets) so an inspecting agent can read them back. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($existing = $storage->load("vcct_eval_tags")) { $existing->delete(); }
  $storage->create([
    "id" => "vcct_eval_tags",
    "label" => "VCCT Eval Tags",
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
              "custom_tag" => "eval:report\neval:widgets",
              "custom_tag_output_lifespan" => "0",
              "custom_tag_output_lifespan_expression" => "",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vcct_eval_tags created with custom_tag cache (tags: eval:report, eval:widgets)"
