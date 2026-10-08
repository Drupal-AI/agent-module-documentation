#!/usr/bin/env bash
# Introspection SETUP: give node.article a KNOWN Link field (field_lc_intro) whose default
# form-display component uses the link_class_field_widget in FORCE mode with a distinctive
# forced class ("btn btn-primary"), so an inspecting agent can read the widget id, mode and
# forced class back with drush. The field does not ship by default, so it is safe to
# create/delete. Idempotent (recreated each run). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_lc_intro")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_lc_intro",
      "entity_type" => "node",
      "type" => "link",
      "cardinality" => 1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_lc_intro")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_lc_intro",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Intro link",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_lc_intro", [
    "type" => "link_class_field_widget",
    "weight" => 20,
    "settings" => [
      "link_class_mode" => "force_class",
      "link_class_force" => "btn btn-primary",
      "link_class_select" => "",
    ],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_lc_intro form display uses link_class_field_widget (force_class, btn btn-primary)"
