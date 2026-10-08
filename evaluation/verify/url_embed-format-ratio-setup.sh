#!/usr/bin/env bash
# Introspection SETUP: create a namespaced text format url_embed_test with the url_embed
# filter enabled and a distinctive default_ratio, so the agent must inspect the live filter
# format config to answer. Does not touch any shipped text format. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  if (!FilterFormat::load("url_embed_test")) {
    FilterFormat::create([
      "format" => "url_embed_test",
      "name" => "URL Embed Test Format",
      "filters" => [
        "url_embed_convert_links" => [
          "id" => "url_embed_convert_links", "status" => TRUE, "weight" => 0,
          "settings" => ["url_prefix" => ""],
        ],
        "url_embed" => [
          "id" => "url_embed", "status" => TRUE, "weight" => 1,
          "settings" => ["enable_responsive" => TRUE, "default_ratio" => "42.5"],
        ],
      ],
    ])->save();
  }
  else {
    $format = FilterFormat::load("url_embed_test");
    $format->setFilterConfig("url_embed", [
      "status" => TRUE, "weight" => 1,
      "settings" => ["enable_responsive" => TRUE, "default_ratio" => "42.5"],
    ]);
    $format->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: text format url_embed_test has url_embed filter with default_ratio=42.5"
