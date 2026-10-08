#!/usr/bin/env bash
# Introspection SETUP: give node.article a KNOWN taxonomy term reference field
# (field_ac_intro) whose default form-display component uses the autocomplete_deluxe widget
# with distinctive settings (match_operator STARTS_WITH, min_length 3, new_terms TRUE) so an
# inspecting agent can read the widget id and its settings back with drush. The field does not
# ship by default, so it is safe to create/delete. Idempotent (recreated each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_ac_intro")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_ac_intro",
      "entity_type" => "node",
      "type" => "entity_reference",
      "settings" => ["target_type" => "taxonomy_term"],
      "cardinality" => -1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_ac_intro")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_ac_intro",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Intro tags",
      "settings" => ["handler" => "default:taxonomy_term", "handler_settings" => []],
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_ac_intro", [
    "type" => "autocomplete_deluxe",
    "weight" => 20,
    "settings" => [
      "match_operator" => "STARTS_WITH",
      "min_length" => 3,
      "new_terms" => TRUE,
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_ac_intro form display uses autocomplete_deluxe (STARTS_WITH, min_length 3, new_terms)"
