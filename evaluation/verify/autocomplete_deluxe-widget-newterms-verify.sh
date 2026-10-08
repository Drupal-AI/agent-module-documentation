#!/usr/bin/env bash
# Live-state verification for the "autocomplete_deluxe widget with free tagging on Article" task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Three independent checks against real entity_form_display config:
#   cmp  — node.article default form display has a component for field_eval_ac
#   wid  — that component's widget type is exactly `autocomplete_deluxe`
#   nt   — its settings enable new terms (new_terms == TRUE / free tagging)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cmp = FALSE; $wid = FALSE; $nt = FALSE; $type = ""; $detail = "";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $c = $fd->getComponent("field_eval_ac");
    if (is_array($c)) {
      $cmp = TRUE;
      $type = $c["type"] ?? "";
      if ($type === "autocomplete_deluxe") { $wid = TRUE; }
      $nt = !empty($c["settings"]["new_terms"]);
      $detail = "type=" . $type . " new_terms=" . (($c["settings"]["new_terms"] ?? "") ? 1 : 0);
    }
  }
  $ok = $cmp && $wid && $nt;
  print ($ok ? "PASS" : "FAIL") . " cmp=" . ($cmp?1:0) . " wid=" . ($wid?1:0) . " nt=" . ($nt?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
