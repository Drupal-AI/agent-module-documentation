#!/usr/bin/env bash
# Execution RESET: make node:article eligible for Smart Title but ensure the node.article.default
# display has Smart Title OFF and no smart_title component, so verify FAILS until the agent
# enables it. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("smart_title.settings")->set("smart_title", ["node:article"])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setThirdPartySetting("smart_title", "enabled", FALSE)
     ->unsetThirdPartySetting("smart_title", "settings")
     ->removeComponent("smart_title")
     ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node:article eligible; node.article.default Smart Title OFF, no component"
