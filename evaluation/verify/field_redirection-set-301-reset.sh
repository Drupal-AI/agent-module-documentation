#!/usr/bin/env bash
# Execution RESET: ensure a link field field_fr_link exists on Article rendered with the core
# 'link' formatter (NOT the redirect formatter) on the default view display, so verify FAILS
# until the agent switches it to field_redirection_formatter with code 301. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fr_link")) {
    FieldStorageConfig::create(["field_name" => "field_fr_link", "entity_type" => "node", "type" => "link"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fr_link")) {
    FieldConfig::create(["field_name" => "field_fr_link", "entity_type" => "node", "bundle" => "article", "label" => "Link"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fr_link", [
    "type" => "link", "label" => "above", "weight" => 46, "region" => "content", "settings" => [],
  ])->save();
' >/dev/null 2>&1
echo "reset: node.article field_fr_link uses core link formatter (NOT redirect)"
