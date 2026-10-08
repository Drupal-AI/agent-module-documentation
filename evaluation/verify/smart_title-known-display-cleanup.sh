#!/usr/bin/env bash
# Introspection CLEANUP: remove Smart Title from node.article.default and empty the eligible
# bundle list. Restores baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->unsetThirdPartySetting("smart_title", "enabled")
     ->unsetThirdPartySetting("smart_title", "settings")
     ->removeComponent("smart_title")
     ->save();
  \Drupal::configFactory()->getEditable("smart_title.settings")->set("smart_title", [])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "cleanup: Smart Title removed from node.article.default; eligible list emptied"
