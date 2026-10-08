#!/usr/bin/env bash
# Introspection SETUP (bp_media): create a bp_media paragraph carrying a distinctive set of the
# suite's shared styling values (bp_width, bp_margin, bp_padding, bp_background) on an article,
# so the agent must read the live paragraph to report them. No media entity needed - the
# styling fields are the subject. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  if (!FieldStorageConfig::loadByName("node", "field_bpmedia_styles")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpmedia_styles", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bpmedia_styles");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bpmedia_styles", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Media Styles",
    ]);
  }
  $fc->setSetting("handler", "default:paragraph");
  $fc->setSetting("handler_settings", ["target_bundles" => ["bp_media" => "bp_media"]]);
  $fc->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bpmedia_styles", ["type" => "entity_reference_paragraphs", "weight" => 67, "region" => "content"])->save();
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Media Styled Section")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_media")->condition("bp_header", "Styled Media Section")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  $p = Paragraph::create([
    "type" => "bp_media",
    "bp_header" => "Styled Media Section",
    "bp_width" => "paragraph--width--tiny",
    "bp_margin" => "mt-1 mb-1",
    "bp_padding" => "pt-5 pb-5",
  ]);
  $p->save();
  $n = Node::create(["type" => "article", "title" => "BP Media Styled Section", "status" => 1]);
  $n->set("field_bpmedia_styles", [["target_id" => $p->id(), "target_revision_id" => $p->getRevisionId()]]);
  $n->save();
  print "paragraph=" . $p->id() . " node=" . $n->id() . "\n";
'
drush cr >/dev/null 2>&1
echo "setup: 'BP Media Styled Section' bp_media has width=paragraph--width--tiny margin='mt-1 mb-1' padding='pt-5 pb-5'"
