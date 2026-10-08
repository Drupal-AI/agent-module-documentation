#!/usr/bin/env bash
# Introspection SETUP: create paragraph type pl_text and an entity_reference_revisions field
# field_pl_para on Article using the paragraphs_limits handler with pl_text upper_limit=5,
# lower_limit=1, so an agent can read back the configured maximum. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\paragraphs\Entity\ParagraphsType;
  if (!ParagraphsType::load("pl_text")) { ParagraphsType::create(["id"=>"pl_text","label"=>"PL Text"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_pl_para")) {
    FieldStorageConfig::create(["field_name"=>"field_pl_para","entity_type"=>"node","type"=>"entity_reference_revisions","settings"=>["target_type"=>"paragraph"],"cardinality"=>-1])->save();
  }
  $fc = FieldConfig::loadByName("node","article","field_pl_para") ?: FieldConfig::create(["field_name"=>"field_pl_para","entity_type"=>"node","bundle"=>"article","label"=>"PL Paragraphs"]);
  $fc->setSetting("handler","paragraphs_limits");
  $fc->setSetting("handler_settings",["target_bundles"=>["pl_text"=>"pl_text"],"target_bundles_drag_drop"=>["pl_text"=>["weight"=>0,"enabled"=>TRUE,"lower_limit"=>1,"upper_limit"=>5]]]);
  $fc->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_pl_para uses paragraphs_limits, pl_text upper_limit=5 lower_limit=1"
