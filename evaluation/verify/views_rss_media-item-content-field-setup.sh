#!/usr/bin/env bash
# Introspection SETUP: create View vrss_media_content with a Feed display using the
# Advanced RSS Feed row plugin mapping a known field id to the item <media:content>
# element, so an inspecting agent can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($storage->load("vrss_media_content")) { $storage->load("vrss_media_content")->delete(); }
  $array = [
    "id" => "vrss_media_content",
    "label" => "VRSS Media Content",
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
          "title" => "VRSS Media Content",
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
          "path" => "vrss-media-content.xml",
          "style" => ["type" => "rss_fields"],
          "row" => [
            "type" => "views_rss_fields",
            "options" => [
              "item" => [
                "media" => [
                  "views_rss_media" => [
                    "content" => "field_vrss_media_marker_2210",
                  ],
                ],
              ],
            ],
          ],
          "defaults" => ["style" => FALSE, "row" => FALSE],
        ],
      ],
    ],
  ];
  $storage->create($array)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vrss_media_content item media:content mapped to field_vrss_media_marker_2210"
