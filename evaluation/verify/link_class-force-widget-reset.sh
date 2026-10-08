#!/usr/bin/env bash
# Reset the "configure Link with class widget in FORCE mode on Article" execution task to a
# clean slate. Ensures a Link field node.article.field_lc_force EXISTS (creating it if needed),
# and forces its default form-display component back to the plain core link widget
# (link_default) so verify FAILS until the agent switches it to link_class_field_widget with
# force_class + a forced class. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_lc_force")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_lc_force",
      "entity_type" => "node",
      "type" => "link",
      "cardinality" => 1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_lc_force")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_lc_force",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "CTA link",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_lc_force", [
    "type" => "link_default",
    "weight" => 22,
    "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_lc_force exists, widget forced to core link_default"
