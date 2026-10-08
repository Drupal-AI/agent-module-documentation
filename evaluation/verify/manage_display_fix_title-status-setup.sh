#!/usr/bin/env bash
# Introspection SETUP: put a known manage_display-rendered title into live config (node view
# mode mdft_eval on Article, title formatter with tag=h5) and guarantee the obsolete submodule
# manage_display_fix_title is NOT installed, so the agent must inspect the running site to
# report the submodule's real install status. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall manage_display_fix_title -y >/dev/null 2>&1 || true
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  if (!EntityViewMode::load("node.mdft_eval")) {
    EntityViewMode::create(["id" => "node.mdft_eval", "label" => "MDFT Eval", "targetEntityType" => "node"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $d = $s->load("node.article.mdft_eval") ?: $s->create([
    "targetEntityType" => "node", "bundle" => "article", "mode" => "mdft_eval", "status" => TRUE,
  ]);
  $d->setComponent("title", [
    "type" => "title", "label" => "hidden", "weight" => -49, "region" => "content",
    "settings" => ["link_to_entity" => TRUE, "tag" => "h5"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: node.article.mdft_eval renders title via manage_display (tag=h5); manage_display_fix_title left uninstalled"
