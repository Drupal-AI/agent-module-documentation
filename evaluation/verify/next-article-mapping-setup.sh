#!/usr/bin/env bash
# next introspection SETUP: map node.article to nextzz_m2 (site_selector) with the path revalidator.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\next\Entity\NextSite;
  use Drupal\next\Entity\NextEntityTypeConfig;
  if ($s = NextSite::load("nextzz_m2")) { $s->delete(); }
  NextSite::create(["id" => "nextzz_m2", "label" => "M2 Site", "base_url" => "https://m2.example.com"])->save();
  if ($c = NextEntityTypeConfig::load("node.article")) { $c->delete(); }
  NextEntityTypeConfig::create([
    "id" => "node.article",
    "site_resolver" => "site_selector",
    "configuration" => ["sites" => ["nextzz_m2"]],
    "draft_enabled" => TRUE,
    "revalidator" => "path",
    "revalidator_configuration" => ["revalidate_page" => 1],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: next_entity_type_config node.article site_resolver=site_selector revalidator=path"
