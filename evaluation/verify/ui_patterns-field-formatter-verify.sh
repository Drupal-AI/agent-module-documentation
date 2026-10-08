#!/usr/bin/env bash
# Live-state verification for "render a field through a UI Patterns component formatter".
# PASS when the Article default display has a visible field using ui_patterns_component or
# ui_patterns_component_per_item with a configured component_id. Exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::service("entity_display.repository")->getViewDisplay("node","article","default");
  $ok = FALSE; $field = ""; $type = "";
  foreach ($d->getComponents() as $name => $c) {
    $t = $c["type"] ?? "";
    if (in_array($t, ["ui_patterns_component", "ui_patterns_component_per_item"], TRUE)) {
      if (!empty($c["settings"]["ui_patterns"]["component_id"])) { $ok = TRUE; $field = $name; $type = $t; break; }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " field=" . $field . " type=" . $type . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
