#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the "add entity.node.edit_form to the custom_routes list" task.
# Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
# PASS only if layout_builder_iframe_modal.settings custom_routes contains
# "entity.node.edit_form".
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $raw = \Drupal::config("layout_builder_iframe_modal.settings")->get("custom_routes");
  $vals = is_array($raw) ? array_values($raw) : [];
  $has = in_array("entity.node.edit_form", $vals, TRUE);
  print ($has ? "PASS" : "FAIL")
    . " | custom_routes=[" . implode(",", $vals) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
