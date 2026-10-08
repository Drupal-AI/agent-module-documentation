#!/usr/bin/env bash
# Introspection SETUP: enable the 'footer' menu as an Ultimenu block in ultimenu.settings so an
# inspecting agent can read back which menu is configured as a mega-menu block. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $c = \Drupal::configFactory()->getEditable("ultimenu.settings");
  $blocks = $c->get("blocks") ?: [];
  $blocks["footer"] = "footer";
  $c->set("blocks", $blocks)->save();
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "setup: ultimenu.settings blocks.footer=footer (footer menu is an Ultimenu block)"
