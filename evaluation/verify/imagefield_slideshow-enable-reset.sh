#!/usr/bin/env bash
# Execution RESET: ensure Article has a multi-value image field field_ifs_task whose default
# view-display formatter is the core 'image' formatter (NOT the slideshow), so verify FAILS
# until the agent switches it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ifs_task")) {
    FieldStorageConfig::create(["field_name"=>"field_ifs_task","entity_type"=>"node","type"=>"image","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ifs_task")) {
    FieldConfig::create(["field_name"=>"field_ifs_task","entity_type"=>"node","bundle"=>"article","label"=>"IFS Task"])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_ifs_task", ["type"=>"image","label"=>"hidden","region"=>"content","weight"=>52,"settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ifs_task uses core image formatter"
