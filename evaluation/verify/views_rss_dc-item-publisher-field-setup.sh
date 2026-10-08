#!/usr/bin/env bash
# Introspection SETUP: create View vrss_dc_publisher with a Feed display using the
# Advanced RSS Feed row plugin mapping a known field id to the item <dc:publisher>
# element, so an inspecting agent can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($storage->load("vrss_dc_publisher")) { $storage->load("vrss_dc_publisher")->delete(); }
  $array = [
    "id" => "vrss_dc_publisher",
    "label" => "VRSS DC Publisher",
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
          "title" => "VRSS DC Publisher",
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
          "path" => "vrss-dc-publisher.xml",
          "style" => ["type" => "rss_fields"],
          "row" => [
            "type" => "views_rss_fields",
            "options" => [
              "item" => [
                "dc" => [
                  "views_rss_dc" => [
                    "publisher" => "field_vrss_dc_marker_6642",
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
echo "setup: view vrss_dc_publisher item dc:publisher mapped to field_vrss_dc_marker_6642"
