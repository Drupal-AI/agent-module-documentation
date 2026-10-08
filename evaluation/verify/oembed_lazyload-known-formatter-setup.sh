#!/usr/bin/env bash
# Introspection SETUP: create a text field field_oel_known on Article and set its default view
# display formatter to lazyload_oembed with strategy=onclick, so an agent can read back the
# formatter and its lazy-load strategy. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_oel_known")) {
    FieldStorageConfig::create(["field_name"=>"field_oel_known","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_oel_known")) {
    FieldConfig::create(["field_name"=>"field_oel_known","entity_type"=>"node","bundle"=>"article","label"=>"OEL Known"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_oel_known", ["type"=>"lazyload_oembed","label"=>"hidden","region"=>"content",
      "settings"=>["strategy"=>"onclick","intersection_observer_margin"=>"","max_width"=>640,"max_height"=>360]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_oel_known uses lazyload_oembed (strategy=onclick)"
