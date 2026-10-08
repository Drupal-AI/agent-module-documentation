#!/usr/bin/env bash
# Introspection SETUP: create a link field field_tjm_known on Article and set its formatter on the
# default view display to the TacJS-integrated oEmbed formatter (tacjs_oembed), so an inspecting
# agent can read back which field uses it. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\field\Entity\FieldStorageConfig;
  use Drupal\field\Entity\FieldConfig;
  if (!FieldStorageConfig::loadByName("node","field_tjm_known")) {
    FieldStorageConfig::create(["field_name"=>"field_tjm_known","entity_type"=>"node","type"=>"link"])->save();
  }
  if (!FieldConfig::loadByName("node","article","field_tjm_known")) {
    FieldConfig::create(["field_name"=>"field_tjm_known","entity_type"=>"node","bundle"=>"article","label"=>"Known Video URL"])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("field_tjm_known", ["type"=>"tacjs_oembed","weight"=>50,"region"=>"content","label"=>"hidden","settings"=>[]])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article field_tjm_known uses formatter tacjs_oembed"
