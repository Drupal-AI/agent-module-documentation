#!/usr/bin/env bash
# Introspection SETUP: put TWO paragraphs fields on Article - field_pgc_classic using the classic
# entity_reference_paragraphs widget (enhanced by paragraphs_collapsible) and field_pgc_modern
# using the modern paragraphs widget (NOT enhanced). Agent must identify which one the module
# makes collapsible. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!ParagraphsType::load("pgc_ptype")) { ParagraphsType::create(["id"=>"pgc_ptype","label"=>"PGC Paragraph"])->save(); }
  foreach (["field_pgc_classic","field_pgc_modern"] as $fn) {
    if (!FieldStorageConfig::loadByName("node",$fn)) {
      FieldStorageConfig::create(["field_name"=>$fn,"entity_type"=>"node","type"=>"entity_reference_revisions","settings"=>["target_type"=>"paragraph"],"cardinality"=>-1])->save();
    }
    if (!FieldConfig::loadByName("node","article",$fn)) {
      FieldConfig::create(["field_name"=>$fn,"entity_type"=>"node","bundle"=>"article","label"=>$fn])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_pgc_classic",["type"=>"entity_reference_paragraphs","weight"=>61,"region"=>"content","settings"=>[]]);
  $fd->setComponent("field_pgc_modern",["type"=>"paragraphs","weight"=>62,"region"=>"content","settings"=>[]]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_pgc_classic=entity_reference_paragraphs, field_pgc_modern=paragraphs"
