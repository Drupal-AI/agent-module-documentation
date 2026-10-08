#!/usr/bin/env bash
# Live-state verification for the "Link with class widget, FORCE mode on Article" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Four independent checks against real entity_form_display config for field_lc_force:
#   cmp  — node.article default form display has a component for field_lc_force
#   wid  — that component's widget type is exactly `link_class_field_widget`
#   mode — its settings set link_class_mode to force_class
#   cls  — link_class_force is a non-empty forced class string
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cmp = FALSE; $wid = FALSE; $mode = FALSE; $cls = FALSE; $type = ""; $m = ""; $f = "";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $c = $fd->getComponent("field_lc_force");
    if (is_array($c)) {
      $cmp = TRUE;
      $type = $c["type"] ?? "";
      if ($type === "link_class_field_widget") { $wid = TRUE; }
      $m = $c["settings"]["link_class_mode"] ?? "";
      if ($m === "force_class") { $mode = TRUE; }
      $f = $c["settings"]["link_class_force"] ?? "";
      if (trim($f) !== "") { $cls = TRUE; }
    }
  }
  $ok = $cmp && $wid && $mode && $cls;
  print ($ok ? "PASS" : "FAIL") . " cmp=" . ($cmp?1:0) . " wid=" . ($wid?1:0) . " mode=" . ($mode?1:0) . " cls=" . ($cls?1:0) . " type=" . $type . " link_class_mode=" . $m . " link_class_force=" . $f . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
