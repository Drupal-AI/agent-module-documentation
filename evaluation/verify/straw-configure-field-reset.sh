#!/usr/bin/env bash
# Execution RESET: ensure field_straw_task exists on Article as a term-reference field using the
# DEFAULT handler and the plain entity_reference_autocomplete widget (NOT straw), so verify
# FAILS until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_straw_task")) {
    FieldStorageConfig::create(["field_name"=>"field_straw_task","entity_type"=>"node","type"=>"entity_reference","settings"=>["target_type"=>"taxonomy_term"]])->save();
  }
  if (!($fc = FieldConfig::loadByName("node","article","field_straw_task"))) {
    $fc = FieldConfig::create(["field_name"=>"field_straw_task","entity_type"=>"node","bundle"=>"article","label"=>"Task Topics"]);
  }
  $fc->setSetting("handler","default:taxonomy_term")->setSetting("handler_settings",["target_bundles"=>["tags"=>"tags"]])->save();
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $fd->setComponent("field_straw_task", ["type"=>"entity_reference_autocomplete","weight"=>61,"region"=>"content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_straw_task uses default handler + entity_reference_autocomplete widget"
