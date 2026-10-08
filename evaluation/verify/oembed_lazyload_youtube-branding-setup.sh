#!/usr/bin/env bash
# Introspection SETUP: field_oly_mb on Article uses lazyload_oembed with YouTube modestbranding=true
# (autoplay off), so an agent must inspect third-party settings to say the YouTube logo is hidden.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_oly_mb")) {
    FieldStorageConfig::create(["field_name"=>"field_oly_mb","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_oly_mb")) {
    FieldConfig::create(["field_name"=>"field_oly_mb","entity_type"=>"node","bundle"=>"article","label"=>"OLY MB"])->save();
  }
  \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default")
    ->setComponent("field_oly_mb", ["type"=>"lazyload_oembed","label"=>"hidden","region"=>"content",
      "settings"=>["strategy"=>"intersection_observer","intersection_observer_margin"=>"","max_width"=>0,"max_height"=>0],
      "third_party_settings"=>["oembed_lazyload_youtube"=>["autoplay"=>false,"modestbranding"=>true,"enablejsapi"=>false,"origin"=>false,"hideinfo"=>false,"rel"=>false]]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_oly_mb lazyload_oembed youtube.modestbranding=true"
