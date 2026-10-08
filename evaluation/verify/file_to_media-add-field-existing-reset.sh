#!/usr/bin/env bash
# Execution RESET: (re)create view ftm_target_view on file_managed WITHOUT the file_to_media
# field (only a filename field), so verify FAILS until the agent adds the file_to_media field.
# Idempotent (recreates cleanly). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if ($v = View::load("ftm_target_view")) { $v->delete(); }
  View::create([
    "id" => "ftm_target_view",
    "label" => "FTM Target View",
    "base_table" => "file_managed",
    "base_field" => "fid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Default",
        "position" => 0,
        "display_options" => [
          "fields" => [
            "filename" => [
              "id" => "filename",
              "table" => "file_managed",
              "field" => "filename",
              "plugin_id" => "field",
            ],
          ],
        ],
      ],
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: view ftm_target_view present WITHOUT file_to_media field"
