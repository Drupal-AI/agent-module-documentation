#!/usr/bin/env bash
# Execution VERIFY: PASS when clh_opts line_height_options is exactly the custom set 1 1.5 2
# (order-insensitive). Reads raw editor config (getSettings() prunes default-equal plugin
# settings). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $opts = \Drupal::config("editor.editor.clh_opts")->get("settings.plugins.ckeditor5_line_height_line_height.line_height_options") ?? [];
  $got = array_values(array_map("strval", $opts));
  sort($got);
  $want = ["1", "1.5", "2"]; sort($want);
  $ok = ($got === $want);
  print ($ok ? "PASS" : "FAIL") . " options=" . implode(",", $opts) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
