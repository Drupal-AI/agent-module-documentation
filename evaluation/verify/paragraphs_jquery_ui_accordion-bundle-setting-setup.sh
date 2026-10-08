#!/usr/bin/env bash
# Introspection SETUP: configure the accordion formatter on field_pjqa_faq to read a known
# paragraph bundle (pjqa_faq_item), so an agent can read the formatter's 'bundle' setting.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_pjqa_faq")) {
    FieldStorageConfig::create(["field_name"=>"field_pjqa_faq","entity_type"=>"node","type"=>"entity_reference_revisions","cardinality"=>-1,"settings"=>["target_type"=>"paragraph"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pjqa_faq")) {
    FieldConfig::create(["field_name"=>"field_pjqa_faq","entity_type"=>"node","bundle"=>"article","label"=>"FAQ accordion"])->save();
  }
  $vd=\Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $vd->setComponent("field_pjqa_faq",["type"=>"paragraphs_jquery_ui_accordion_formatter","region"=>"content","weight"=>61,"settings"=>["bundle"=>"pjqa_faq_item","title"=>"field_pjqa_q","content"=>"field_pjqa_a","view_mode"=>"default","active"=>0]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_pjqa_faq accordion formatter bundle=pjqa_faq_item"
