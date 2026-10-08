#!/usr/bin/env bash
# Execution RESET: enable 'main' as an Ultimenu block (so the derivative is placeable) but remove
# any placed ultimenu block instance named ultimenu_um_main, so verify FAILS until the agent places
# the block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ultimenu.settings");
  $blocks = $c->get("blocks") ?: [];
  $blocks["main"] = "main";
  $c->set("blocks", $blocks)->save();
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
  if ($b = \Drupal::entityTypeManager()->getStorage("block")->load("ultimenu_um_main")) { $b->delete(); }
' >/dev/null 2>&1
echo "reset: main enabled as ultimenu block; instance ultimenu_um_main absent"
