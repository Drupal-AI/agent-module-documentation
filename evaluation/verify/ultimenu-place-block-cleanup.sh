#!/usr/bin/env bash
# Execution CLEANUP: delete any placed ultimenu_block:ultimenu-main instance and remove blocks.main
# from ultimenu.settings, dropping the config object if empty. Restores baseline. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  foreach (\Drupal::entityTypeManager()->getStorage("block")->loadMultiple() as $b) {
    if ($b->getPluginId() === "ultimenu_block:ultimenu-main") { $b->delete(); }
  }
  $c = \Drupal::configFactory()->getEditable("ultimenu.settings");
  if (!$c->isNew()) {
    $blocks = $c->get("blocks") ?: [];
    unset($blocks["main"]);
    if (empty($blocks) && empty($c->get("regions")) && empty($c->get("goodies"))) { $c->delete(); }
    else { $c->set("blocks", $blocks)->save(); }
  }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "cleanup: ultimenu main instance + blocks.main removed"
