#!/usr/bin/env bash
# Introspection SETUP: create a paragraphs reference field field_pgc_body on Article whose form
# widget is the CLASSIC entity_reference_paragraphs widget (the only widget paragraphs_collapsible
# enhances), so an agent can read the widget back from the form display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!ParagraphsType::load("pgc_ptype")) { ParagraphsType::create(["id"=>"pgc_ptype","label"=>"PGC Paragraph"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_pgc_body")) {
    FieldStorageConfig::create(["field_name"=>"field_pgc_body","entity_type"=>"node","type"=>"entity_reference_revisions","settings"=>["target_type"=>"paragraph"],"cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pgc_body")) {
    FieldConfig::create(["field_name"=>"field_pgc_body","entity_type"=>"node","bundle"=>"article","label"=>"PGC Body"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_pgc_body",["type"=>"entity_reference_paragraphs","weight"=>60,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_pgc_body form widget = entity_reference_paragraphs (classic)"
