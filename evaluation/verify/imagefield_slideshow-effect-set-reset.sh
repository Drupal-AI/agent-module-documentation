#!/usr/bin/env bash
# Execution RESET: ensure Article has image field field_ifs_effect whose display already uses
# the slideshow formatter but with effect 'fade', so verify FAILS until the agent changes the
# effect to flipHorz. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_ifs_effect")) {
    FieldStorageConfig::create(["field_name"=>"field_ifs_effect","entity_type"=>"node","type"=>"image","cardinality"=>-1])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_ifs_effect")) {
    FieldConfig::create(["field_name"=>"field_ifs_effect","entity_type"=>"node","bundle"=>"article","label"=>"IFS Effect"])->save();
  }
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $d->setComponent("field_ifs_effect", [
    "type"=>"imagefield_slideshow_field_formatter","label"=>"hidden","region"=>"content","weight"=>53,
    "settings"=>["imagefield_slideshow_style"=>"large","imagefield_slideshow_style_effects"=>"fade"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: field_ifs_effect slideshow effect=fade"
