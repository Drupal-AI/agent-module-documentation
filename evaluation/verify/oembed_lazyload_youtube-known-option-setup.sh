#!/usr/bin/env bash
# Introspection SETUP: create a text field field_oly_known on Article using the lazyload_oembed
# formatter with the YouTube third-party setting autoplay=true, so an agent can read back which
# YouTube player option is enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_oly_known")) {
    FieldStorageConfig::create(["field_name"=>"field_oly_known","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_oly_known")) {
    FieldConfig::create(["field_name"=>"field_oly_known","entity_type"=>"node","bundle"=>"article","label"=>"OLY Known"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_oly_known", ["type"=>"lazyload_oembed","label"=>"hidden","region"=>"content",
      "settings"=>["strategy"=>"onclick","intersection_observer_margin"=>"","max_width"=>0,"max_height"=>0],
      "third_party_settings"=>["oembed_lazyload_youtube"=>["autoplay"=>true,"modestbranding"=>false,"enablejsapi"=>false,"origin"=>false,"hideinfo"=>false,"rel"=>false]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_oly_known lazyload_oembed youtube.autoplay=true"
