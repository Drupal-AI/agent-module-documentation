#!/usr/bin/env bash
# Execution VERIFY: PASS when the field_micon_pkg widget on the default form display is
# restricted to exactly the `fa` package (settings.packages filtered keys == [fa]).
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $c = $fd ? $fd->getComponent("field_micon_pkg") : NULL;
  $pkgs = $c["settings"]["packages"] ?? [];
  $selected = array_keys(array_filter($pkgs));
  $ok = $selected === ["fa"];
  print ($ok ? "PASS" : "FAIL") . " packages=" . json_encode($selected) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
