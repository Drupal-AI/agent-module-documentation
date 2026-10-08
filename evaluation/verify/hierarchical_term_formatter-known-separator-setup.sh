#!/usr/bin/env bash
# setup: node.article field_htf_sep uses hierarchical_term_formatter separator=" / "
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!Vocabulary::load("htf_sep")) { Vocabulary::create(["vid" => "htf_sep", "name" => "htf_sep"])->save(); }
  if (!FieldStorageConfig::loadByName("node", "field_htf_sep")) {
    FieldStorageConfig::create(["field_name" => "field_htf_sep", "entity_type" => "node", "type" => "entity_reference", "settings" => ["target_type" => "taxonomy_term"]])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_htf_sep")) {
    FieldConfig::create(["field_name" => "field_htf_sep", "entity_type" => "node", "bundle" => "article", "label" => "field_htf_sep", "settings" => ["handler" => "default:taxonomy_term", "handler_settings" => ["target_bundles" => ["htf_sep" => "htf_sep"]]]])->save();
  }
  $vd = \Drupal::service("entity_display.repository")->getViewDisplay("node", "article", "default");
  $vd->setComponent("field_htf_sep", ["type" => "hierarchical_term_formatter", "label" => "above", "weight" => 50, "region" => "content", "settings" => ["display" => "all", "link" => FALSE, "wrap" => "none", "separator" => " / ", "reverse" => FALSE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_htf_sep uses hierarchical_term_formatter separator=" / ""
