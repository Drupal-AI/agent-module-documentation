#!/usr/bin/env bash
# Introspection SETUP: same field, Facet link formatter configured to link to a known facet id.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_erfl_ref2")) {
    \Drupal\field\Entity\FieldStorageConfig::create(["field_name"=>"field_erfl_ref2","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_erfl_ref2")) {
    \Drupal\field\Entity\FieldConfig::create(["field_name"=>"field_erfl_ref2","entity_type"=>"node","bundle"=>"article","label"=>"ERFL Ref2"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_erfl_ref2",["type"=>"entity_reference_facet_link","settings"=>["facet"=>"erfl_news_topics"],"label"=>"above","weight"=>51,"region"=>"content"])->save();
' >/dev/null 2>&1
echo "setup: field_erfl_ref2 Facet link formatter links to facet erfl_news_topics"
