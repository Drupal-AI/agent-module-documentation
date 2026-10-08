#!/usr/bin/env bash
# medium SETUP (altcha_obfuscate): create email field field_aobf_email on Article and set its default
# view-display formatter to altcha_obfuscated_email. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_aobf_email")) {
    FieldStorageConfig::create(["field_name" => "field_aobf_email", "entity_type" => "node", "type" => "email"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_aobf_email")) {
    FieldConfig::create(["field_name" => "field_aobf_email", "entity_type" => "node", "bundle" => "article", "label" => "AOBF Email"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_aobf_email", ["type" => "altcha_obfuscated_email", "label" => "hidden", "weight" => 50])->save();
' >/dev/null 2>&1
echo "setup: field_aobf_email uses altcha_obfuscated_email formatter"
