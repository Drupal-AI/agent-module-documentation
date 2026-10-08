#!/usr/bin/env bash
# Execution RESET: ensure link field field_tjm_task exists on Article and its default view-display
# formatter is the plain core 'link' formatter (NOT tacjs_oembed) so verify FAILS until the agent
# switches it. Creates the field if missing. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_tjm_task")) {
    FieldStorageConfig::create(["field_name"=>"field_tjm_task","entity_type"=>"node","type"=>"link"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_tjm_task")) {
    FieldConfig::create(["field_name"=>"field_tjm_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Video URL"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_tjm_task", ["type"=>"link","weight"=>50,"region"=>"content","label"=>"above","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article field_tjm_task uses formatter link (not tacjs_oembed)"
