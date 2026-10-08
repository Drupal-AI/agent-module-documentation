#!/usr/bin/env bash
# Execution RESET: (re)create media type mc_fmt_type with the Crowdriff source and a default
# view display whose field uses the media_crowdriff formatter with DEFAULT size (100%/900px),
# so verify (which wants 640px/480px) FAILS until the agent changes the formatter. Idempotent.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\media\Entity\MediaType;
  if (!MediaType::load("mc_fmt_type")) {
    $t = MediaType::create(["id"=>"mc_fmt_type","label"=>"MC Formatter Type","source"=>"media_crowdriff"]);
    $t->save();
    $f = $t->getSource()->createSourceField($t);
    $f->getFieldStorageDefinition()->save();
    $f->save();
    $t->set("source_configuration",["source_field"=>$f->getName()])->save();
  }
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.mc_fmt_type.default");
  if (!$vd) {
    $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->create([
      "targetEntityType"=>"media","bundle"=>"mc_fmt_type","mode"=>"default","status"=>TRUE,
    ]);
  }
  $vd->setComponent("field_media_media_crowdriff", [
    "type"=>"media_crowdriff","weight"=>0,"region"=>"content",
    "settings"=>["width"=>"100%","height"=>"900px"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: mc_fmt_type formatter at default 100%/900px"
