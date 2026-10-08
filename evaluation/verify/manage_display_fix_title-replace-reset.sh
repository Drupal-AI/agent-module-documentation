#!/usr/bin/env bash
# Execution RESET: create the node view mode mdft_task on Article whose title component sits at
# the manage_display defaults (tag=h2, linked), and make sure the obsolete submodule
# manage_display_fix_title is NOT installed. verify FAILS until the agent achieves the
# submodule's former goal - a single unlinked H1 title - through the parent module instead.
# Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush pm:uninstall manage_display_fix_title -y >/dev/null 2>&1 || true
drush php:eval '
  use Drupal\Core\Entity\Entity\EntityViewMode;
  if (!EntityViewMode::load("node.mdft_task")) {
    EntityViewMode::create(["id" => "node.mdft_task", "label" => "MDFT Task", "targetEntityType" => "node"])->save();
  }
  $s = \Drupal::entityTypeManager()->getStorage("entity_view_display");
  $d = $s->load("node.article.mdft_task") ?: $s->create([
    "targetEntityType" => "node", "bundle" => "article", "mode" => "mdft_task", "status" => TRUE,
  ]);
  $d->setComponent("title", [
    "type" => "title", "label" => "hidden", "weight" => -49, "region" => "content",
    "settings" => ["link_to_entity" => TRUE, "tag" => "h2"],
  ])->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: node.article.mdft_task title at defaults (tag=h2, linked); manage_display_fix_title uninstalled"
