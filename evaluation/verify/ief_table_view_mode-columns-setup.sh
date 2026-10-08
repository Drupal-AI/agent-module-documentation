#!/usr/bin/env bash
# Introspection SETUP: create the Inline Entity Form Table (ief_table) view display for
# node.article with the body field as a visible column, so an agent can inspect the columns.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $vd = $s->load("node.article.ief_table");
  if (!$vd) {
    $vd = $s->create(["targetEntityType"=>"node","bundle"=>"article","mode"=>"ief_table","status"=>TRUE]);
  }
  $vd->setStatus(TRUE);
  $vd->setComponent("body", ["type"=>"text_default","label"=>"hidden","weight"=>1]);
  $vd->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.ief_table view display has body as a column"
