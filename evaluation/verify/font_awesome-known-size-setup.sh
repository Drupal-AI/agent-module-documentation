#!/usr/bin/env bash
# Introspection SETUP: create a string field field_fa_known on Article and set its default view
# display to the font_awesome_icon formatter with size fa-2x, so an agent can read it back.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node", "field_fa_known")) {
    FieldStorageConfig::create(["field_name"=>"field_fa_known","entity_type"=>"node","type"=>"string"])->save();
  }
  if (!FieldConfig::loadByName("node", "article", "field_fa_known")) {
    FieldConfig::create(["field_name"=>"field_fa_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Icon"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_fa_known", ["type"=>"font_awesome_icon","weight"=>50,"region"=>"content","settings"=>["size"=>"fa-2x","fixed_width"=>"fa-fw"],"label"=>"hidden"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: field_fa_known formatter=font_awesome_icon size=fa-2x"
