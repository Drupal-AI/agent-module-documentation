#!/usr/bin/env bash
# Execution RESET: ensure the hard fixture exists and its FORM display uses the default
# Paragraphs widget (not the table widget), so verify FAILS until the agent switches it.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!ParagraphsType::load("pt_evh")) { ParagraphsType::create(["id"=>"pt_evh","label"=>"PT Eval Hard"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_pt_evh")) {
    FieldStorageConfig::create(["field_name"=>"field_pt_evh","entity_type"=>"node","type"=>"entity_reference_revisions","settings"=>["target_type"=>"paragraph"],"cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pt_evh")) {
    FieldConfig::create(["field_name"=>"field_pt_evh","entity_type"=>"node","bundle"=>"article","label"=>"PT Eval Hard","settings"=>["handler"=>"default:paragraph","handler_settings"=>["target_bundles"=>["pt_evh"=>"pt_evh"]]]])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $d->setComponent("field_pt_evh", ["type"=>"paragraphs","region"=>"content","weight"=>50])->save();
' >/dev/null 2>&1
echo "reset: field_pt_evh form display uses default paragraphs widget"
