#!/usr/bin/env bash
# Execution RESET: set scheme-1 config with NO permissions granted, so verify FAILS until the
# agent grants node view. Config-only; tac_lite_categories stays null so no node grants are
# emitted (no node_access rebuild needed, nothing broken). Exit 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("tac_lite.settings")
    ->set("tac_lite_config_scheme_1", [
      "name" => "Scheme 1",
      "perms" => [],
      "unpublished" => FALSE,
      "term_visibility" => FALSE,
    ])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: tac_lite scheme 1 grants no permissions"
