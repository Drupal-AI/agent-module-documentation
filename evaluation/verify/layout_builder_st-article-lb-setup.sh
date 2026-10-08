#!/usr/bin/env bash
# Introspection SETUP: enable Layout Builder per-entity overrides on node.article.default so
# layout_builder_st auto-creates the layout_builder__translation field. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $d = $s->load("node.article.default") ?: $s->create(["targetEntityType"=>"node","bundle"=>"article","mode"=>"default","status"=>TRUE]);
  $d->enableLayoutBuilder()->setOverridable(TRUE)->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.default LB overrides ON; layout_builder__translation added"
