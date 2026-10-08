#!/usr/bin/env bash
# Execution RESET: ensure a link field field_fr_temp exists on Article with the core 'link'
# formatter on the default view display, so verify FAILS until the agent switches it to
# field_redirection_formatter with a 302 code AND "404 if empty" enabled. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fr_temp")) {
    FieldStorageConfig::create(["field_name" => "field_fr_temp", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fr_temp")) {
    FieldConfig::create(["field_name" => "field_fr_temp", "entity_type" => "node", "bundle" => "article", "label" => "Temp Target"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fr_temp", [
    "type" => "link", "label" => "above", "weight" => 47, "region" => "content", "settings" => [],
  ])->save();
' >/dev/null 2>&1
echo "reset: node.article field_fr_temp uses core link formatter (NOT redirect)"
