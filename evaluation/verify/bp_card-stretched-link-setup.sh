#!/usr/bin/env bash
# Introspection SETUP (bp_card): create TWO Card paragraphs on two articles — one with
# bp_link_entire_card = TRUE ("BP Card Clickable") and one with it FALSE ("BP Card Plain") —
# so the agent must read live paragraph field values to say which whole card is clickable.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  if (!FieldStorageConfig::loadByName("node", "field_bpcard_pair")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpcard_pair", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bpcard_pair");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bpcard_pair", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Card Pair",
    ]);
  }
  $fc->setSetting("handler", "default:paragraph");
  $fc->setSetting("handler_settings", ["target_bundles" => ["bp_card" => "bp_card"]]);
  $fc->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bpcard_pair", ["type" => "entity_reference_paragraphs", "weight" => 64, "region" => "content"])->save();
  foreach (["BP Card Clickable", "BP Card Plain"] as $title) {
    $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", $title)->execute();
    if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  }
  foreach (["Clickable Card", "Plain Card"] as $t) {
    $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_card")->condition("bp_card_title", $t)->execute();
    if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
  }
  $spec = [
    ["BP Card Clickable", "Clickable Card", TRUE,  "btn btn-primary"],
    ["BP Card Plain",     "Plain Card",     FALSE, "btn btn-light"],
  ];
  foreach ($spec as [$nodeTitle, $cardTitle, $entire, $btn]) {
    $p = Paragraph::create([
      "type" => "bp_card", "bp_card_style" => "card--large-top",
      "bp_card_title" => $cardTitle, "bp_link_entire_card" => $entire,
      "bp_card_button_style" => $btn,
      "bp_card_link" => ["uri" => "https://example.com/", "title" => "More"],
    ]);
    $p->save();
    $n = Node::create(["type" => "article", "title" => $nodeTitle, "status" => 1]);
    $n->set("field_bpcard_pair", [["target_id" => $p->id(), "target_revision_id" => $p->getRevisionId()]]);
    $n->save();
  }
  print "created 2 nodes\n";
'
drush cr >/dev/null 2>&1
echo "setup: 'BP Card Clickable' card has bp_link_entire_card=1, 'BP Card Plain' has 0"
