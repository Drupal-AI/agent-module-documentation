#!/usr/bin/env bash
# Introspection SETUP: create a View vrss_p_desc with a Feed display using the
# Advanced RSS Feed style plugin (rss_fields) and a known channel <description>
# text, so an inspecting agent can read it back from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $storage = \Drupal::entityTypeManager()->getStorage("view");
  if ($storage->load("vrss_p_desc")) {
    $storage->load("vrss_p_desc")->delete();
  }
  $array = [
    "id" => "vrss_p_desc",
    "label" => "VRSS Parent Channel Description",
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
          "title" => "VRSS Parent Channel Description",
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
          "path" => "vrss-p-desc.xml",
          "style" => [
            "type" => "rss_fields",
            "options" => [
              "channel" => [
                "core" => [
                  "views_rss_core" => [
                    "description" => "Views RSS QA marker: kiwi-9182",
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
echo "setup: view vrss_p_desc has channel description = kiwi-9182 marker"
