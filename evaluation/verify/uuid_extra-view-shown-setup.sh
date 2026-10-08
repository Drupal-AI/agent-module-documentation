#!/usr/bin/env bash
# Introspection SETUP (uuid_extra): enable rendering of the node UUID on the Article default
# VIEW display using the uuid formatter. Known fact to read back: the UUID IS shown on the
# Article default view display. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $vd->setComponent("uuid", ["type" => "uuid", "label" => "inline", "weight" => 99, "region" => "content"])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article default view display renders uuid (uuid formatter)"
