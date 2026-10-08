#!/usr/bin/env bash
# reset: node.article field_htf_cats present with entity_reference_label (not hierarchical)
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!Vocabulary::load("htf_cats")) { Vocabulary::create(["vid" => "htf_cats", "name" => "htf_cats"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_htf_cats")) {
    FieldStorageConfig::create(["field_name" => "field_htf_cats", "entity_type" => "node", "type" => "entity_reference", "settings" => ["target_type" => "taxonomy_term"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_htf_cats")) {
    FieldConfig::create(["field_name" => "field_htf_cats", "entity_type" => "node", "bundle" => "article", "label" => "field_htf_cats", "settings" => ["handler" => "default:taxonomy_term", "handler_settings" => ["target_bundles" => ["htf_cats" => "htf_cats"]]]])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $vd->setComponent("field_htf_cats", ["type" => "entity_reference_label", "label" => "above", "weight" => 50, "region" => "content", "settings" => ["link" => TRUE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_htf_cats present with entity_reference_label (not hierarchical)"
