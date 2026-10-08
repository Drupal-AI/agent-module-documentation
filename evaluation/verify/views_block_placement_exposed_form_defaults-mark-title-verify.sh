#!/usr/bin/env bash
# Execution VERIFY: PASS when vbpefd_task block_1 customizable_exposed_filters includes 'title'.
# Read-only. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $c = \Drupal::config("views.view.vbpefd_task")->get("display.block_1.display_options.customizable_exposed_filters") ?: [];
  $ok = in_array("title", array_values($c), TRUE) || isset($c["title"]);
  print (($ok) ? "PASS" : "FAIL") . " customizable=" . json_encode($c) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
