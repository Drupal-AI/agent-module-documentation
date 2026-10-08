#!/usr/bin/env bash
# Execution RESET (bp_callout): provide an empty paragraphs field field_bpcallout_build on
# Article that accepts the Callout bundle, and delete any node titled
# "BP Callout Build Target" plus any bp_callout paragraph headed "Safety Notice".
# The agent must then build the callout content itself. verify FAILS on this state.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  use Drupal\node\Entity\Node;
  use Drupal\paragraphs\Entity\Paragraph;
  if (!FieldStorageConfig::loadByName("node", "field_bpcallout_build")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpcallout_build", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bpcallout_build");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bpcallout_build", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Callout Build",
    ]);
  }
  $fc->setSetting("handler", "default:paragraph");
  $fc->setSetting("handler_settings", ["target_bundles" => ["bp_callout" => "bp_callout"]]);
  $fc->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bpcallout_build", ["type" => "entity_reference_paragraphs", "weight" => 62, "region" => "content"])->save();
  $ids = \Drupal::entityQuery("node")->accessCheck(FALSE)->condition("title", "BP Callout Build Target")->execute();
  if ($ids) { \Drupal::entityTypeManager()->getStorage("node")->delete(Node::loadMultiple($ids)); }
  $pids = \Drupal::entityQuery("paragraph")->accessCheck(FALSE)->condition("type", "bp_callout")->condition("bp_header", "Safety Notice")->execute();
  if ($pids) { \Drupal::entityTypeManager()->getStorage("paragraph")->delete(Paragraph::loadMultiple($pids)); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_bpcallout_build exists and is empty; no 'BP Callout Build Target' node"
