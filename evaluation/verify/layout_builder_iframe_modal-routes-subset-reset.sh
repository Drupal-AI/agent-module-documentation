#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution RESET: empty layout_builder_iframe_routes (no built-in LB route opens in the
# iframe modal) and clear custom_routes, so the "enable iframe for ONLY Add block + Update
# block" task starts from empty and the verify FAILs until the agent builds the exact subset.
# Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_iframe_modal.settings")
    ->set("layout_builder_iframe_routes", [])
    ->set("custom_routes", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: layout_builder_iframe_routes = [] (empty; subset task starts from nothing)"
