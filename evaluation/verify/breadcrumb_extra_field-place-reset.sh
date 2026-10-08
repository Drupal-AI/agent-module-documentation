#!/usr/bin/env bash
# Execution RESET: enable the breadcrumb extra field for node/article in config (so the field is
# available) but ensure the 'breadcrumb' component is NOT on the Article default display; verify
# FAILS until the agent places it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("breadcrumb_extra_field.settings")
    ->set("breadcrumb_extra_field_admin", ["node"=>["article"=>"article"]])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd && $vd->getComponent("breadcrumb")) { $vd->removeComponent("breadcrumb")->save(); }
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node/article enabled in config; breadcrumb component removed from display"
