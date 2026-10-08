#!/usr/bin/env bash
# Execution VERIFY: PASS when field_micon_lkt_task uses the micon_linkit widget. Exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","article","default");
  $c = $fd->getComponent("field_micon_lkt_task");
  print ((($c["type"] ?? "") === "micon_linkit") ? "PASS" : "FAIL") . " widget=" . ($c["type"] ?? "none") . "\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q "^PASS" && exit 0 || exit 1
