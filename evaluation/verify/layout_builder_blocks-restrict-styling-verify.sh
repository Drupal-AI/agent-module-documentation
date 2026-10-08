#!/usr/bin/env bash
# HARD execution verify for "restrict the Style tab to the Site branding block".
# PASS when layout_builder_blocks.styles:block_restrictions contains system_branding_block.
# Prints PASS/FAIL and exits 0 (pass) / 1 (fail).
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $r = \Drupal::config("layout_builder_blocks.styles")->get("block_restrictions") ?: [];
  $ok = in_array("system_branding_block", $r, TRUE);
  print ($ok ? "PASS" : "FAIL") . " block_restrictions=" . json_encode(array_values($r)) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
