#!/usr/bin/env bash
# Introspection SETUP: configure tac_lite scheme 1 with tac_lite_create (form-term visibility)
# ENABLED so an inspecting agent can read it back. Config-only; tac_lite_categories stays null.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tac_lite.settings")
    ->set("tac_lite_config_scheme_1", [
      "name" => "Create scheme",
      "perms" => ["grant_view" => "grant_view"],
      "unpublished" => FALSE,
      "term_visibility" => FALSE,
      "tac_lite_create" => TRUE,
    ])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tac_lite scheme 1 tac_lite_create=TRUE"
