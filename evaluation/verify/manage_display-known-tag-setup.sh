#!/usr/bin/env bash
# Introspection SETUP: create the namespaced node view mode "md_eval" and a node.article
# display for it whose `title` base-field component uses the manage_display `title` formatter
# with tag=h4 and link_to_entity=FALSE, so an inspecting agent can read the heading tag back
# from live config. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  if (!EntityViewMode::load("node.md_eval")) {
    EntityViewMode::create(["id" => "node.md_eval", "label" => "MD Eval", "targetEntityType" => "node"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $d = $s->load("node.article.md_eval") ?: $s->create([
    "targetEntityType" => "node", "bundle" => "article", "mode" => "md_eval", "status" => TRUE,
  ]);
  $d->setComponent("title", [
    "type" => "title", "label" => "hidden", "weight" => -49, "region" => "content",
    "settings" => ["link_to_entity" => FALSE, "tag" => "h4"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.md_eval title component uses formatter 'title' with tag=h4, link_to_entity=false"
