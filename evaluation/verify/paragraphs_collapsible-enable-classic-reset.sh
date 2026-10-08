#!/usr/bin/env bash
# Execution RESET: create a paragraphs field field_pgc_task on Article whose form widget is the
# MODERN 'paragraphs' widget (so paragraphs_collapsible does NOT enhance it), so verify FAILS
# until the agent switches it to the classic entity_reference_paragraphs widget. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!ParagraphsType::load("pgc_ptype")) { ParagraphsType::create(["id"=>"pgc_ptype","label"=>"PGC Paragraph"])->save(); }
  if (!FieldStorageConfig::loadByName("node","field_pgc_task")) {
    FieldStorageConfig::create(["field_name"=>"field_pgc_task","entity_type"=>"node","type"=>"entity_reference_revisions","settings"=>["target_type"=>"paragraph"],"cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_pgc_task")) {
    FieldConfig::create(["field_name"=>"field_pgc_task","entity_type"=>"node","bundle"=>"article","label"=>"PGC Task"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_pgc_task",["type"=>"paragraphs","weight"=>63,"region"=>"content","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_pgc_task form widget = paragraphs (modern)"
