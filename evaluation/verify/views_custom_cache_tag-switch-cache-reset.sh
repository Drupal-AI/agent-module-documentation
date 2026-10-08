#!/usr/bin/env bash
# Execution RESET for the "switch an existing view's cache plugin to custom_tag" task:
# (re)create the view vcct_hard_switch with the CORE `tag` cache plugin (NOT custom_tag) and
# no custom tags, so verify FAILs before the agent acts. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($existing = $storage->load("vcct_hard_switch")) { $existing->delete(); }
  $storage->create([
    "id" => "vcct_hard_switch",
    "label" => "VCCT Hard Switch",
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
            "type" => "tag",
            "options" => [],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view vcct_hard_switch created with core tag cache plugin (baseline: not custom_tag)"
