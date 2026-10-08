#!/usr/bin/env bash
# Introspection SETUP: mark node:article eligible in smart_title.settings and enable Smart
# Title on node.article.default with tag h1, class article__title, unlinked. Agent inspects
# the live view display to report the configured tag. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("smart_title.settings")->set("smart_title", ["node:article"])->save();
  \Drupal\Core\Cache\Cache::invalidateTags(["entity_field_info"]);
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setThirdPartySetting("smart_title", "enabled", TRUE)
     ->setThirdPartySetting("smart_title", "settings", [
       "smart_title__tag" => "h1",
       "smart_title__classes" => ["article__title"],
       "smart_title__link" => FALSE,
     ])
     ->setComponent("smart_title", ["weight" => -5, "region" => "content"])
     ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.default Smart Title enabled, tag=h1, link=false"
