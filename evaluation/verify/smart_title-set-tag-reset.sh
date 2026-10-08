#!/usr/bin/env bash
# Execution RESET: enable Smart Title on node.article.default with the DEFAULT tag h2 and
# link=TRUE, so verify (which wants tag h1 + link false) FAILS until the agent changes it.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("smart_title.settings")->set("smart_title", ["node:article"])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setThirdPartySetting("smart_title", "enabled", TRUE)
     ->setThirdPartySetting("smart_title", "settings", [
       "smart_title__tag" => "h2",
       "smart_title__classes" => ["node__title"],
       "smart_title__link" => TRUE,
     ])
     ->setComponent("smart_title", ["weight" => -5, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.default Smart Title enabled tag=h2 link=true"
