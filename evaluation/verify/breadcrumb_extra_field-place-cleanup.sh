#!/usr/bin/env bash
# Execution CLEANUP: remove the breadcrumb display component and clear the enabled-entities
# config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd && $vd->getComponent("breadcrumb")) { $vd->removeComponent("breadcrumb")->save(); }
  \Drupal::configFactory()->getEditable("breadcrumb_extra_field.settings")
    ->set("breadcrumb_extra_field_admin", [])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: breadcrumb component + config cleared"
