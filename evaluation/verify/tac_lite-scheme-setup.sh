#!/usr/bin/env bash
# Introspection SETUP: write a known scheme-1 config into tac_lite.settings so an inspecting
# agent can read back its name and granted permission. Config-only (no node_access rebuild),
# and tac_lite_categories is left null so no grants are ever emitted. Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tac_lite.settings")
    ->set("tac_lite_config_scheme_1", [
      "name" => "Read access",
      "perms" => ["grant_view" => "grant_view"],
      "unpublished" => FALSE,
      "term_visibility" => TRUE,
    ])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tac_lite scheme 1 name='Read access' perms=[grant_view]"
