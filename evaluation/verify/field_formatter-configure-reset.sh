#!/usr/bin/env bash
# Execution RESET: ensure entity_reference field field_ff_task (node->article) exists on
# Article, with its DEFAULT view-display component using the core default
# 'entity_reference_label' formatter (NOT a field_formatter formatter), so verify FAILS until
# the agent switches it to field_formatter_from_view_display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_ff_task")) {
    FieldStorageConfig::create(["field_name"=>"field_ff_task","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"node"]])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ff_task")) {
    FieldConfig::create(["field_name"=>"field_ff_task","entity_type"=>"node","bundle"=>"article","label"=>"FF Task","settings"=>["handler"=>"default:node","handler_settings"=>["target_bundles"=>["article"=>"article"]]]])->save();
  }
  $vd=\Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_ff_task", ["type"=>"entity_reference_label","label"=>"above","region"=>"content","weight"=>60,"settings"=>["link"=>TRUE]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ff_task uses core entity_reference_label formatter"
