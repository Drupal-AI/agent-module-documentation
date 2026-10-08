#!/usr/bin/env bash
# Introspection CLEANUP: remove the footer entry from ultimenu.settings blocks (and delete the
# config object if it becomes empty) to restore baseline. Idempotent. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  $cf = \Drupal::configFactory();
  $c = $cf->getEditable("ultimenu.settings");
  $blocks = $c->get("blocks") ?: [];
  unset($blocks["footer"]);
  if (empty($blocks) && empty($c->get("regions")) && empty($c->get("goodies"))) {
    $c->delete();
  } else {
    $c->set("blocks", $blocks)->save();
  }
  \Drupal::service("plugin.manager.block")->clearCachedDefinitions();
' >/dev/null 2>&1
echo "cleanup: ultimenu.settings blocks.footer removed"
