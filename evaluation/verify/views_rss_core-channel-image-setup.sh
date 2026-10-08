#!/usr/bin/env bash
# Introspection SETUP: create View vrss_c_image with a Feed display using the Advanced
# RSS Feed style plugin and a known channel <image> path, so an inspecting agent can
# read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($storage->load("vrss_c_image")) { $storage->load("vrss_c_image")->delete(); }
  $array = [
    "id" => "vrss_c_image",
    "label" => "VRSS Core Channel Image",
    "module" => "views",
    "base_table" => "node_field_data",
    "base_field" => "nid",
    "display" => [
      "default" => [
        "display_plugin" => "default",
        "id" => "default",
        "display_title" => "Master",
        "position" => 0,
        "display_options" => [
          "title" => "VRSS Core Channel Image",
          "style" => ["type" => "default"],
          "row" => ["type" => "fields"],
        ],
      ],
      "feed_1" => [
        "display_plugin" => "feed",
        "id" => "feed_1",
        "display_title" => "Feed",
        "position" => 1,
        "display_options" => [
          "path" => "vrss-c-image.xml",
          "style" => [
            "type" => "rss_fields",
            "options" => [
              "channel" => [
                "core" => [
                  "views_rss_core" => [
                    "image" => "sites/default/files/vrss-core-qa-9911.png",
                  ],
                ],
              ],
            ],
          ],
          "row" => ["type" => "views_rss_fields"],
          "defaults" => ["style" => FALSE, "row" => FALSE],
        ],
      ],
    ],
  ];
  $storage->create($array)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vrss_c_image channel image = vrss-core-qa-9911.png marker"
