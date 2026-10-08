#!/usr/bin/env bash
# Introspection SETUP: place a Copyright Footer block (id cf_range) with a known
# year_origin so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("cf_range")) { $b->delete(); }
  Block::create([
    "id" => "cf_range", "plugin" => "copyright_footer",
    "region" => "content", "theme" => $theme, "weight" => 91,
    "settings" => [
      "id" => "copyright_footer", "label" => "Copyright Footer", "label_display" => FALSE,
      "organization_name" => "Range Co", "organization_url" => "",
      "year_origin" => 2011, "year_to_date" => "", "version" => "", "version_url" => "",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block.block.cf_range placed with year_origin=2011"
