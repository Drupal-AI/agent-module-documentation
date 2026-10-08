#!/usr/bin/env bash
# Introspection SETUP: create View vrss_fmt_enclosure with a Feed display mapping a known
# field id to the item <enclosure> element (an attribute-bearing element that depends on
# views_rss_format's attribute pass-through to render correctly), so an inspecting agent
# can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($storage->load("vrss_fmt_enclosure")) { $storage->load("vrss_fmt_enclosure")->delete(); }
  $array = [
    "id" => "vrss_fmt_enclosure",
    "label" => "VRSS Format Enclosure",
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
          "title" => "VRSS Format Enclosure",
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
          "path" => "vrss-fmt-enclosure.xml",
          "style" => ["type" => "rss_fields"],
          "row" => [
            "type" => "views_rss_fields",
            "options" => [
              "item" => [
                "core" => [
                  "views_rss_core" => [
                    "enclosure" => "field_vrss_fmt_marker_8823",
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
drush en views_rss_format -y >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: view vrss_fmt_enclosure item enclosure mapped to field_vrss_fmt_marker_8823, views_rss_format enabled"
