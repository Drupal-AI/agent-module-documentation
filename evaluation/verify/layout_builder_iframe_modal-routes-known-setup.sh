#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Introspection SETUP: put layout_builder_iframe_modal.settings into a KNOWN state where the
# "Add block" route is NOT enabled — layout_builder_iframe_routes holds the other 9 built-in
# routes but omits layout_builder.add_block (exactly as unchecking that box in the settings
# form would save). An agent reads it back with
# `drush config:get layout_builder_iframe_modal.settings layout_builder_iframe_routes`.
# Idempotent. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_iframe_modal.settings")
    ->set("layout_builder_iframe_routes", [
      "layout_builder.configure_section","layout_builder.remove_section","layout_builder.remove_block",
      "layout_builder.add_section","layout_builder.update_block",
      "layout_builder.move_sections_form","layout_builder.move_block_form",
      "layout_builder.translate_block","layout_builder.translate_inline_block",
    ])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "setup: layout_builder_iframe_routes = 9 routes (layout_builder.add_block OMITTED)"
