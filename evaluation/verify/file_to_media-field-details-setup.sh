#!/usr/bin/env bash
# Introspection SETUP: create view ftm_second_view (base file_managed) with the file_to_media
# field and a page display served at /ftm-second. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\views\Entity\View;
  if (!View::load("ftm_second_view")) {
    View::create([
      "id" => "ftm_second_view",
      "label" => "FTM Second View",
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
        "page_1" => [
          "display_plugin" => "page",
          "id" => "page_1",
          "display_title" => "Page",
          "position" => 1,
          "display_options" => [
            "path" => "ftm-second",
          ],
        ],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view ftm_second_view created (file_to_media field, page at /ftm-second)"
