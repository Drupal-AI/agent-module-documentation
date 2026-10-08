#!/usr/bin/env bash
# Introspection SETUP: place a Copyright Footer block (id cf_known) with a known
# organization_name so an inspecting agent can read it back. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\block\Entity\Block;
  $theme = \Drupal::config("system.theme")->get("default");
  if ($b = Block::load("cf_known")) { $b->delete(); }
  Block::create([
    "id" => "cf_known", "plugin" => "copyright_footer",
    "region" => "content", "theme" => $theme, "weight" => 90,
    "settings" => [
      "id" => "copyright_footer", "label" => "Copyright Footer", "label_display" => FALSE,
      "organization_name" => "Acme Widgets Ltd", "organization_url" => "",
      "year_origin" => "", "year_to_date" => "", "version" => "", "version_url" => "",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: block.block.cf_known placed with organization_name='Acme Widgets Ltd'"
