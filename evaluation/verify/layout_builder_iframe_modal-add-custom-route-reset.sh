#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution RESET: clear layout_builder_iframe_modal.settings back to install defaults so the
# "add entity.node.edit_form to custom_routes" task starts from empty custom_routes and the
# verify FAILs until the agent does the work. Restores the 10 built-in LB routes too. Exits 0.
set -uo pipefail
cd /var/www/html
drush php:eval '
  \Drupal::configFactory()->getEditable("layout_builder_iframe_modal.settings")
    ->set("layout_builder_iframe_routes", [
      "layout_builder.configure_section","layout_builder.remove_section","layout_builder.remove_block",
      "layout_builder.add_section","layout_builder.add_block","layout_builder.update_block",
      "layout_builder.move_sections_form","layout_builder.move_block_form",
      "layout_builder.translate_block","layout_builder.translate_inline_block",
    ])
    ->set("custom_routes", [])
    ->save();
' >/dev/null 2>&1
drush cr >/dev/null 2>&1
echo "reset: custom_routes = [] (baseline; add_custom_route task starts empty)"
