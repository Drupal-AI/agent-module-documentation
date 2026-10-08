#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: put layout_builder_iframe_modal.settings into a KNOWN state by adding
# a distinctive custom route to custom_routes, exactly as the settings-form textarea would
# save it. An inspecting agent can read it back with
# `drush config:get layout_builder_iframe_modal.settings custom_routes`. Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_iframe_modal.settings")
    ->set("custom_routes", ["my_module.special_dialog"])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: layout_builder_iframe_modal.settings custom_routes = [my_module.special_dialog]"
