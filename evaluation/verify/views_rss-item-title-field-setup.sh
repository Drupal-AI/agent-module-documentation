#!/usr/bin/env bash
# Introspection SETUP: create a View vrss_p_item with a Feed display using the
# Advanced RSS Feed row plugin (views_rss_fields) mapping a known field id to the
# item <title> element, so an inspecting agent can read it back from live config.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($storage->load("vrss_p_item")) {
    $storage->load("vrss_p_item")->delete();
  }
  $array = [
    "id" => "vrss_p_item",
    "label" => "VRSS Parent Item Title Field",
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
          "title" => "VRSS Parent Item Title Field",
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
          "path" => "vrss-p-item.xml",
          "style" => ["type" => "rss_fields"],
          "row" => [
            "type" => "views_rss_fields",
            "options" => [
              "item" => [
                "core" => [
                  "views_rss_core" => [
                    "title" => "field_vrss_marker_7734",
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
echo "setup: view vrss_p_item item title mapped to field_vrss_marker_7734"
