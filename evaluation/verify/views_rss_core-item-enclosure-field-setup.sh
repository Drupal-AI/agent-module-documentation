#!/usr/bin/env bash
# Introspection SETUP: create View vrss_c_enclosure with a Feed display using the
# Advanced RSS Feed row plugin mapping a known field id to the item <enclosure>
# element, so an inspecting agent can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($storage->load("vrss_c_enclosure")) { $storage->load("vrss_c_enclosure")->delete(); }
  $array = [
    "id" => "vrss_c_enclosure",
    "label" => "VRSS Core Item Enclosure",
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
          "title" => "VRSS Core Item Enclosure",
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
          "path" => "vrss-c-enclosure.xml",
          "style" => ["type" => "rss_fields"],
          "row" => [
            "type" => "views_rss_fields",
            "options" => [
              "item" => [
                "core" => [
                  "views_rss_core" => [
                    "enclosure" => "field_vrss_core_marker_5521",
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
echo "setup: view vrss_c_enclosure item enclosure mapped to field_vrss_core_marker_5521"
