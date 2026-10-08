#!/usr/bin/env bash
# hard RESET (altcha_obfuscate): ensure email field field_aobf_mail exists on Article displayed with
# the default 'basic_string' formatter so verify FAILS until obfuscated with reveal override. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig; use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_aobf_mail")) {
    FieldStorageConfig::create(["field_name" => "field_aobf_mail", "entity_type" => "node", "type" => "email"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_aobf_mail")) {
    FieldConfig::create(["field_name" => "field_aobf_mail", "entity_type" => "node", "bundle" => "article", "label" => "AOBF Mail"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_aobf_mail", ["type" => "basic_string", "label" => "above", "weight" => 52, "settings" => []])->save();
' >/dev/null 2>&1
echo "reset: field_aobf_mail displayed with basic_string formatter"
