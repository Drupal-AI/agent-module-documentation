#!/usr/bin/env bash
# Execution RESET: ensure the 'content' menu is NOT enabled as an Ultimenu block, so verify FAILS
# until the agent enables it. Deletes ultimenu.settings if that leaves it empty. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ultimenu.settings");
  if (!$c->isNew()) {
    $blocks = $c->get("blocks") ?: [];
    unset($blocks["content"]);
    if (empty($blocks) && empty($c->get("regions")) && empty($c->get("goodies"))) { $c->delete(); }
    else { $c->set("blocks", $blocks)->save(); }
  }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "reset: ultimenu.settings has no blocks.content"
