#!/usr/bin/env bash
# Execution RESET: ensure a namespaced text format url_embed_task exists with both url_embed
# filter plugins present but DISABLED (status=false), so verify FAILS until the agent enables
# them. Creates the format if missing. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\filter\Entity\FilterFormat;
  $format = FilterFormat::load("url_embed_task");
  if (!$format) {
    $format = FilterFormat::create([
      "format" => "url_embed_task",
      "name" => "URL Embed Task Format",
    ]);
  }
  $format->setFilterConfig("url_embed_convert_links", [
    "id" => "url_embed_convert_links", "status" => FALSE, "weight" => 0,
    "settings" => ["url_prefix" => ""],
  ]);
  $format->setFilterConfig("url_embed", [
    "id" => "url_embed", "status" => FALSE, "weight" => 1,
    "settings" => ["enable_responsive" => TRUE, "default_ratio" => "66.7"],
  ]);
  $format->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: url_embed_task format present, url_embed + url_embed_convert_links filters DISABLED"
