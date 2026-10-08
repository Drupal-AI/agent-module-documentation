#!/usr/bin/env bash
# Introspection SETUP: create a view ftm_known_view on the file_managed base table carrying the
# file_to_media Views field, so an inspecting agent can find which view has the create-media
# button. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("ftm_known_view")) {
    View::create([
      "id" => "ftm_known_view",
      "label" => "FTM Known View",
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
              "file_to_media" => [
                "id" => "file_to_media",
                "table" => "file_managed",
                "field" => "file_to_media",
                "plugin_id" => "file_to_media",
              ],
            ],
          ],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view ftm_known_view created with the file_to_media field"
