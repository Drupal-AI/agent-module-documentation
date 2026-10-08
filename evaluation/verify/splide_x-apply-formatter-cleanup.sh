#!/usr/bin/env bash
# CLEANUP: reset the field_images display component back to the plain image formatter (keep the field,
# which splide_x's shipped view depends on).
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd && $vd->getComponent("field_images")) {
    $vd->setComponent("field_images", ["type"=>"image","label"=>"hidden","weight"=>70,"region"=>"content","settings"=>[]])->save();
  }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: field_images display reset to plain image formatter"
