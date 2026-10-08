#!/usr/bin/env bash
# Introspection SETUP: create a paragraph type pp_probe and TWO Paragraphs fields on Article -
# field_pp_known (widget paragraphs_previewer) and field_pp_plain (stock widget paragraphs) -
# so the agent must read the live form display to tell which one has the previewer.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\paragraphs\Entity\ParagraphsType;
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!ParagraphsType::load("pp_probe")) {
    ParagraphsType::create(["id" => "pp_probe", "label" => "PP Probe"])->save();
  }
  foreach (["field_pp_known" => "Known Sections", "field_pp_plain" => "Plain Sections"] as $fn => $label) {
    if (!FieldStorageConfig::loadByName("node", $fn)) {
      FieldStorageConfig::create([
        "field_name" => $fn, "entity_type" => "node",
        "type" => "entity_reference_revisions", "cardinality" => -1,
        "settings" => ["target_type" => "paragraph"],
      ])->save();
    }
    if (!FieldConfig::loadByName("node", "article", $fn)) {
      FieldConfig::create([
        "field_name" => $fn, "entity_type" => "node", "bundle" => "article",
        "label" => $label,
        "settings" => ["handler" => "default:paragraph", "handler_settings" => ["target_bundles" => ["pp_probe" => "pp_probe"]]],
      ])->save();
    }
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_pp_known", ["type" => "paragraphs_previewer", "weight" => 60, "region" => "content", "settings" => ["edit_mode" => "closed"]]);
  $fd->setComponent("field_pp_plain", ["type" => "paragraphs", "weight" => 61, "region" => "content"]);
  $fd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_pp_known=paragraphs_previewer, field_pp_plain=paragraphs"
