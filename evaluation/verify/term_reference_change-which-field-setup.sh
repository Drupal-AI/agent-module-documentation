#!/usr/bin/env bash
# Introspection SETUP: add TWO entity_reference fields to Article — field_trc_primary
# (target_type: taxonomy_term) and field_trc_related (target_type: node). Only the first is
# a taxonomy term reference, so only it is returned by ReferenceFinder::findTermReferenceFields().
# The agent must inspect the live field definitions to tell them apart. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\taxonomy\Entity\Vocabulary;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!Vocabulary::load("trc_subjects")) {
    Vocabulary::create(["vid" => "trc_subjects", "name" => "TRC Subjects"])->save();
  }
  $specs = [
    "field_trc_primary" => ["taxonomy_term", "TRC Primary Subject"],
    "field_trc_related" => ["node", "TRC Related Content"],
  ];
  foreach ($specs as $name => [$target, $label]) {
    if (!FieldStorageConfig::loadByName("node", $name)) {
      FieldStorageConfig::create([
        "field_name" => $name, "entity_type" => "node",
        "type" => "entity_reference", "settings" => ["target_type" => $target],
        "cardinality" => 1,
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $name)) {
      FieldConfig::create([
        "field_name" => $name, "entity_type" => "node", "bundle" => "article",
        "label" => $label,
      ])->save();
    }
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: article has field_trc_primary (taxonomy_term) and field_trc_related (node)"
