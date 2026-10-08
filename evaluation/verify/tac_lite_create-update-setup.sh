#!/usr/bin/env bash
# Introspection SETUP: configure tac_lite scheme 1 to grant UPDATE (grant_update) with the
# tac_lite_create checkbox itself left OFF. Because schemes granting update imply form-term
# visibility, an inspecting agent should conclude tac_lite_create filtering applies. Config-only.
# Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tac_lite.settings")
    ->set("tac_lite_config_scheme_1", [
      "name" => "Editor scheme",
      "perms" => ["grant_update" => "grant_update"],
      "unpublished" => FALSE,
      "term_visibility" => FALSE,
      "tac_lite_create" => FALSE,
    ])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: tac_lite scheme 1 perms=[grant_update], tac_lite_create=FALSE"
