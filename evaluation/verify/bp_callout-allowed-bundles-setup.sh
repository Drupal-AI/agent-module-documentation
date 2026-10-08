#!/usr/bin/env bash
# Introspection SETUP (bp_callout): add a paragraphs field field_bpcallout_probe to Article
# whose handler_settings.target_bundles allow exactly two bundles — bp_callout and bp_simple —
# so an inspecting agent must read the live field config to say which bundles it accepts.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_bpcallout_probe")) {
    FieldStorageConfig::create([
      "field_name" => "field_bpcallout_probe", "entity_type" => "node",
      "type" => "entity_reference_revisions", "cardinality" => -1,
      "settings" => ["target_type" => "paragraph"],
    ])->save();
  }
  $fc = FieldConfig::loadByName("node", "article", "field_bpcallout_probe");
  if (!$fc) {
    $fc = FieldConfig::create([
      "field_name" => "field_bpcallout_probe", "entity_type" => "node",
      "bundle" => "article", "label" => "BP Callout Probe",
    ]);
  }
  $fc->setSetting("handler", "default:paragraph");
  $fc->setSetting("handler_settings", ["target_bundles" => [
    "bp_callout" => "bp_callout", "bp_simple" => "bp_simple",
  ]]);
  $fc->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_bpcallout_probe", ["type" => "entity_reference_paragraphs", "weight" => 61, "region" => "content"])->save();
  print "target_bundles=" . implode(",", array_keys($fc->getSetting("handler_settings")["target_bundles"])) . "\n";
'
drush cr >/dev/null 2>&1
echo "setup: node.article field_bpcallout_probe allows bp_callout + bp_simple"
