#!/usr/bin/env bash
# Execution RESET: create the namespaced node view mode "md_author" and a node.article display
# for it with NO byline — the owner field `uid` and `created` are removed from the content
# region (manage_display's own defaults hide them), so verify FAILS until the agent adds the
# `submitted` formatter with a user picture. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  if (!EntityViewMode::load("node.md_author")) {
    EntityViewMode::create(["id" => "node.md_author", "label" => "MD Author", "targetEntityType" => "node"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $d = $s->load("node.article.md_author") ?: $s->create([
    "targetEntityType" => "node", "bundle" => "article", "mode" => "md_author", "status" => TRUE,
  ]);
  $d->removeComponent("uid");
  $d->removeComponent("created");
  $d->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.md_author has no uid/created components (no byline)"
