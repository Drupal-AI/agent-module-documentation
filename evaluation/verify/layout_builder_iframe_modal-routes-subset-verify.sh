#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the "enable the iframe modal for ONLY Add block + Update block"
# task. Prints PASS/FAIL with detail; exits 0 (pass) / 1 (fail). No arguments.
# PASS only if layout_builder_iframe_routes contains EXACTLY layout_builder.add_block and
# layout_builder.update_block (order-independent) and nothing else.
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $raw = \Drupal::config("layout_builder_iframe_modal.settings")->get("layout_builder_iframe_routes");
  $vals = is_array($raw) ? array_values(array_unique($raw)) : [];
  sort($vals);
  $want = ["layout_builder.add_block","layout_builder.update_block"];
  sort($want);
  $ok = ($vals === $want);
  print ($ok ? "PASS" : "FAIL")
    . " | layout_builder_iframe_routes=[" . implode(",", $vals) . "]\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
