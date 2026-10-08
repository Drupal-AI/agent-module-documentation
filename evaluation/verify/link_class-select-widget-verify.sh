#!/usr/bin/env bash
# Live-state verification for the "Link with class widget, SELECT mode on Article" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Four independent checks against real entity_form_display config for field_lc_style:
#   cmp  — node.article default form display has a component for field_lc_style
#   wid  — that component's widget type is exactly `link_class_field_widget`
#   mode — its settings set link_class_mode to select_class
#   opt  — link_class_select defines at least one key|label option line
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cmp = FALSE; $wid = FALSE; $mode = FALSE; $opt = FALSE; $type = ""; $m = ""; $sel = "";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $c = $fd->getComponent("field_lc_style");
    if (is_array($c)) {
      $cmp = TRUE;
      $type = $c["type"] ?? "";
      if ($type === "link_class_field_widget") { $wid = TRUE; }
      $m = $c["settings"]["link_class_mode"] ?? "";
      if ($m === "select_class") { $mode = TRUE; }
      $sel = $c["settings"]["link_class_select"] ?? "";
      if (strpos($sel, "|") !== FALSE) { $opt = TRUE; }
    }
  }
  $ok = $cmp && $wid && $mode && $opt;
  print ($ok ? "PASS" : "FAIL") . " cmp=" . ($cmp?1:0) . " wid=" . ($wid?1:0) . " mode=" . ($mode?1:0) . " opt=" . ($opt?1:0) . " type=" . $type . " link_class_mode=" . $m . " link_class_select=" . str_replace("\n", "\\n", $sel) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
