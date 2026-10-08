#!/usr/bin/env bash
# Introspection SETUP: create the namespaced node view mode "md_byline" and a node.article
# display where the owner field `uid` uses the manage_display `submitted` formatter with the
# user_picture setting pointing at the "compact" user view mode. Also adds a `created`
# timestamp component so the byline sentence has a date. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  if (!EntityViewMode::load("node.md_byline")) {
    EntityViewMode::create(["id" => "node.md_byline", "label" => "MD Byline", "targetEntityType" => "node"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $d = $s->load("node.article.md_byline") ?: $s->create([
    "targetEntityType" => "node", "bundle" => "article", "mode" => "md_byline", "status" => TRUE,
  ]);
  $d->setComponent("uid", [
    "type" => "submitted", "label" => "hidden", "weight" => -50, "region" => "content",
    "settings" => ["user_picture" => "compact"],
  ]);
  $d->setComponent("created", [
    "type" => "timestamp", "label" => "hidden", "weight" => -48, "region" => "content",
    "settings" => ["date_format" => "medium", "custom_date_format" => "", "timezone" => ""],
  ]);
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.md_byline uid uses formatter 'submitted' with user_picture=compact"
