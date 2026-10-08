#!/usr/bin/env bash
# Execution RESET: create a social_links field field_slf_widget on Article and place its
# social_links widget on the default form display with disable_weight=FALSE (reordering allowed),
# so verify FAILS until the agent turns "Disable order" on. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_slf_widget")) {
    FieldStorageConfig::create(["field_name"=>"field_slf_widget","entity_type"=>"node","type"=>"social_links","cardinality"=>3])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_slf_widget")) {
    FieldConfig::create(["field_name"=>"field_slf_widget","entity_type"=>"node","bundle"=>"article","label"=>"Widget Social Links"])->save();
  }
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_slf_widget", [
    "type"=>"social_links","weight"=>50,"region"=>"content",
    "settings"=>["select_social"=>FALSE,"disable_weight"=>FALSE],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_slf_widget present, widget disable_weight=FALSE"
