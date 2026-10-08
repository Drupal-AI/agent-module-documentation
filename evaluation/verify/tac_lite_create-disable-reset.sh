#!/usr/bin/env bash
# Execution RESET: configure tac_lite scheme 1 with tac_lite_create form-term visibility ON,
# so verify FAILS until the agent turns it OFF. Config-only. Exit 0.
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
echo "reset: tac_lite scheme 1 tac_lite_create=TRUE"
