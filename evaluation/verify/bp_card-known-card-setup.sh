#!/usr/bin/env bash
# Introspection SETUP (bp_card): put a real Card paragraph on a node so an agent can read back
# its Card Style and Card Button Style. Creates field_bpcard_known on Article limited to
# bp_card, an article "BP Card Known Promo", and a bp_card paragraph with
# bp_card_style = card--small-left, bp_card_button_style = "btn btn-warning",
# bp_link_entire_card = TRUE. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  if (!FieldStorageConfig::loadByName("node", "field_bpcard_known")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpcard_known", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bpcard_known");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bpcard_known", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Card Known",
    ]);
  }
  $fc->setSetting("handler", "default:paragraph");
  $fc->setSetting("handler_settings", ["target_bundles" => ["bp_card" => "bp_card"]]);
  $fc->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bpcard_known", ["type" => "entity_reference_paragraphs", "weight" => 63, "region" => "content"])->save();
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Card Known Promo")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_card")->condition("bp_card_title", "Known Promo Card")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  $p = Paragraph::create([
    "type" => "bp_card",
    "bp_card_style" => "card--small-left",
    "bp_card_title" => "Known Promo Card",
    "bp_card_text" => "Set up by the bp_card introspection eval.",
    "bp_card_button_style" => "btn btn-warning",
    "bp_link_entire_card" => TRUE,
    "bp_margin" => "mt-5 mb-5",
  ]);
  $p->save();
  $n = Node::create(["type" => "article", "title" => "BP Card Known Promo", "status" => 1]);
  $n->set("field_bpcard_known", [["target_id" => $p->id(), "target_revision_id" => $p->getRevisionId()]]);
  $n->save();
  print "node=" . $n->id() . " paragraph=" . $p->id() . "\n";
'
drush cr >/dev/null 2>&1
echo "setup: 'BP Card Known Promo' has a bp_card with style=card--small-left button=btn btn-warning"
