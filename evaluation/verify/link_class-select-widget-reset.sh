#!/usr/bin/env bash
# Reset the "configure Link with class widget in SELECT mode on Article" execution task to a
# clean slate. Ensures a Link field node.article.field_lc_style EXISTS (creating it if needed),
# and forces its default form-display component back to the plain core link widget
# (link_default) so verify FAILS until the agent switches it to link_class_field_widget with
# select_class + a key|label option list. Idempotent. Rebuilds caches. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  if (!\Drupal\field\Entity\FieldStorageConfig::loadByName("node", "field_lc_style")) {
    \Drupal\field\Entity\FieldStorageConfig::create([
      "field_name" => "field_lc_style",
      "entity_type" => "node",
      "type" => "link",
      "cardinality" => 1,
    ])->save();
  }
  if (!\Drupal\field\Entity\FieldConfig::loadByName("node", "article", "field_lc_style")) {
    \Drupal\field\Entity\FieldConfig::create([
      "field_name" => "field_lc_style",
      "entity_type" => "node",
      "bundle" => "article",
      "label" => "Styled link",
    ])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if (!$fd) {
    $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->create([
      "targetEntityType" => "node", "bundle" => "article", "mode" => "default", "status" => TRUE,
    ]);
  }
  $fd->setComponent("field_lc_style", [
    "type" => "link_default",
    "weight" => 23,
    "settings" => [],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_lc_style exists, widget forced to core link_default"
