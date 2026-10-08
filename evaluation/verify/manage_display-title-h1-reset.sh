#!/usr/bin/env bash
# Execution RESET: create the namespaced node view mode "md_task" and a node.article display
# for it whose `title` component is at the manage_display defaults (tag=h2, link_to_entity=TRUE),
# so verify FAILS until the agent changes it to an unlinked h1. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  if (!EntityViewMode::load("node.md_task")) {
    EntityViewMode::create(["id" => "node.md_task", "label" => "MD Task", "targetEntityType" => "node"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $d = $s->load("node.article.md_task") ?: $s->create([
    "targetEntityType" => "node", "bundle" => "article", "mode" => "md_task", "status" => TRUE,
  ]);
  $d->setComponent("title", [
    "type" => "title", "label" => "hidden", "weight" => -49, "region" => "content",
    "settings" => ["link_to_entity" => TRUE, "tag" => "h2"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.md_task title component at defaults (tag=h2, link_to_entity=true)"
