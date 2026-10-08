#!/usr/bin/env bash
# Execution RESET for "clone field_ft_widget (with its form widget) from Article to Page".
# Ensure field_ft_widget exists on node.article with a component on the article default form
# display, and ensure Page has neither the field nor a form-display component (so verify FAILS).
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ft_widget")) {
    FieldStorageConfig::create([
      "field_name" => "field_ft_widget", "entity_type" => "node", "type" => "string",
    ])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_ft_widget")) {
    FieldConfig::create([
      "field_name" => "field_ft_widget", "entity_type" => "node",
      "bundle" => "article", "label" => "FT Widget",
    ])->save();
  }
  $etm = \Drupal::entityTypeManager();
  $afd = $etm->getStorage("entity_form_display")->load("node.article.default");
  $afd->setComponent("field_ft_widget", [
    "type" => "string_textfield", "weight" => 50, "region" => "content",
  ])->save();
  // Remove from page: field instance and any form-display component.
  if ($fc = FieldConfig::loadByName("node", "page", "field_ft_widget")) { $fc->delete(); }
  $pfd = $etm->getStorage("entity_form_display")->load("node.page.default");
  if ($pfd && $pfd->getComponent("field_ft_widget")) {
    $pfd->removeComponent("field_ft_widget")->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ft_widget on node.article (with form-display component); absent on node.page"
