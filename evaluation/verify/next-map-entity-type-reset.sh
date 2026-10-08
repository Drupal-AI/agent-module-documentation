#!/usr/bin/env bash
# next execution RESET: ensure the target next_site nextzz_map EXISTS (a precondition given in the
# prompt) and the next_entity_type_config node.page is ABSENT so verify fails on empty state.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\next\Entity\NextSite;
  use Drupal\next\Entity\NextEntityTypeConfig;
  if ($c = NextEntityTypeConfig::load("node.page")) { $c->delete(); }
  if (!NextSite::load("nextzz_map")) {
    NextSite::create(["id" => "nextzz_map", "label" => "Map Site", "base_url" => "https://map.example.com"])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: nextzz_map present, next_entity_type_config node.page absent"
