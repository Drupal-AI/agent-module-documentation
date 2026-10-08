#!/usr/bin/env bash
# Introspection SETUP (bp_callout): put a real Callout paragraph on a node so an agent can
# read back its Callout Style. Creates an entity_reference_revisions field
# field_bpcallout_known on Article limited to the bp_callout bundle, an article node
# "BP Callout Known Notice", and a bp_callout paragraph on it with
# bp_callout_style = callout-style--info and bp_header = "Known Callout".
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  if (!FieldStorageConfig::loadByName("node", "field_bpcallout_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpcallout_known", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_bpcallout_known")) {
    FieldConfig::create([
      "field_name" => "field_bpcallout_known", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Callout Known",
      "settings" => ["handler" => "default:paragraph", "handler_settings" => [
        "target_bundles" => ["bp_callout" => "bp_callout"],
      ]],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bpcallout_known", ["type" => "entity_reference_paragraphs", "weight" => 60, "region" => "content"])->save();
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Callout Known Notice")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_callout")->condition("bp_header", "Known Callout")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  $p = Paragraph::create([
    "type" => "bp_callout",
    "bp_callout_style" => "callout-style--info",
    "bp_header" => "Known Callout",
    "bp_width" => "paragraph--width--medium",
  ]);
  $p->save();
  $n = Node::create(["type" => "article", "title" => "BP Callout Known Notice", "status" => 1]);
  $n->set("field_bpcallout_known", [["target_id" => $p->id(), "target_revision_id" => $p->getRevisionId()]]);
  $n->save();
  print "node=" . $n->id() . " paragraph=" . $p->id() . "\n";
' 2>&1 
drush cr >/dev/null 2>&1
echo "setup: node 'BP Callout Known Notice' has a bp_callout paragraph with bp_callout_style=callout-style--info"
