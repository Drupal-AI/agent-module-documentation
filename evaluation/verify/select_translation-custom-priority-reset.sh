#!/usr/bin/env bash
# Execution RESET for "add the Select translation filter in CUSTOM LIST mode with priorities
# en,fr,current to view st_eval_priority". Forces a known baseline where the view EXISTS but
# has NO select_translation filter, so verify FAILS until the agent adds and configures it.
# Recreates the view with only a core "published" filter. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($v = $storage->load("st_eval_priority")) { $v->delete(); }
  $storage->create([
    "id" => "st_eval_priority",
    "label" => "ST Eval Priority",
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
            "status" => [
              "id" => "status",
              "table" => "node_field_data",
              "field" => "status",
              "plugin_id" => "boolean",
              "value" => "1",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view st_eval_priority created WITHOUT a select_translation filter (agent must add it, list mode en,fr,current)"
