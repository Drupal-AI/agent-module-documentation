#!/usr/bin/env bash
# Execution RESET (bp_card): provide an empty paragraphs field field_bpcard_build on Article
# that accepts the Card bundle, and delete any node titled "BP Card Build Target" plus any
# bp_card paragraph titled "Annual Report". The agent must build the card itself.
# verify FAILS here. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  if (!FieldStorageConfig::loadByName("node", "field_bpcard_build")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpcard_build", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bpcard_build");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bpcard_build", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Card Build",
    ]);
  }
  $fc->setSetting("handler", "default:paragraph");
  $fc->setSetting("handler_settings", ["target_bundles" => ["bp_card" => "bp_card"]]);
  $fc->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bpcard_build", ["type" => "entity_reference_paragraphs", "weight" => 65, "region" => "content"])->save();
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Card Build Target")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_card")->condition("bp_card_title", "Annual Report")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_bpcard_build exists and is empty; no 'BP Card Build Target' node"
