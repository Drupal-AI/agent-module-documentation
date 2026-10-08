#!/usr/bin/env bash
# Live-state verification for the "autocomplete_deluxe widget, prefix matching on Article" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Three independent checks against real entity_form_display config:
#   cmp  — node.article default form display has a component for field_eval_tags
#   wid  — that component's widget type is exactly `autocomplete_deluxe`
#   mo   — its settings set match_operator to STARTS_WITH (prefix matching)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cmp = FALSE; $wid = FALSE; $mo = FALSE; $type = ""; $detail = "";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $c = $fd->getComponent("field_eval_tags");
    if (is_array($c)) {
      $cmp = TRUE;
      $type = $c["type"] ?? "";
      if ($type === "autocomplete_deluxe") { $wid = TRUE; }
      $op = $c["settings"]["match_operator"] ?? "";
      if ($op === "STARTS_WITH") { $mo = TRUE; }
      $detail = "type=" . $type . " match_operator=" . $op;
    }
  }
  $ok = $cmp && $wid && $mo;
  print ($ok ? "PASS" : "FAIL") . " cmp=" . ($cmp?1:0) . " wid=" . ($wid?1:0) . " mo=" . ($mo?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
