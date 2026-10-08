#!/usr/bin/env bash
# Introspection SETUP: create field_erfl_ref on Article and set its default view-display
# formatter to the Facet link formatter, so the agent can read back the formatter in use.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node","field_erfl_ref")) {
    \Drupal\field\Entity\FieldStorageConfig::create(["field_name"=>"field_erfl_ref","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node","article","field_erfl_ref")) {
    \Drupal\field\Entity\FieldConfig::create(["field_name"=>"field_erfl_ref","entity_type"=>"node","bundle"=>"article","label"=>"ERFL Ref"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_erfl_ref",["type"=>"entity_reference_facet_link","settings"=>["facet"=>"erfl_known_facet"],"label"=>"above","weight"=>50,"region"=>"content"])->save();
' >/dev/null 2>&1
echo "setup: node.article field_erfl_ref uses formatter entity_reference_facet_link (facet=erfl_known_facet)"
