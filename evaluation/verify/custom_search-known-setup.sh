#!/usr/bin/env bash
# MEDIUM introspection SETUP: place a Custom Search block (id custom_search_probe) restricted to
# the 'article' content type, so an agent can read the block plugin/settings back. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if (!Block::load("custom_search_probe")) {
    Block::create([
      "id" => "custom_search_probe", "plugin" => "custom_search", "region" => "content",
      "theme" => $theme, "weight" => 0, "status" => TRUE,
      "settings" => [
        "id" => "custom_search", "label" => "Search articles", "label_display" => "0",
        "content" => ["types" => ["article" => "article"]],
      ],
    ])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: Custom Search block custom_search_probe (restricted to article)"
