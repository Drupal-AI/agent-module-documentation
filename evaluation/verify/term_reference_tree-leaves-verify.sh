#!/usr/bin/env bash
# Live-state verification for the "term_reference_tree widget, leaves-only + minimized on
# Article" task. Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Four independent checks against real entity_form_display config:
#   cmp  — node.article default form display has a component for field_eval_trt2
#   wid  — that component's widget type is exactly `term_reference_tree`
#   lo   — its settings set leaves_only to TRUE
#   sm   — its settings set start_minimized to TRUE
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cmp = FALSE; $wid = FALSE; $lo = FALSE; $sm = FALSE; $type = ""; $detail = "";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $c = $fd->getComponent("field_eval_trt2");
    if (is_array($c)) {
      $cmp = TRUE;
      $type = $c["type"] ?? "";
      if ($type === "term_reference_tree") { $wid = TRUE; }
      $lo = !empty($c["settings"]["leaves_only"]);
      $sm = !empty($c["settings"]["start_minimized"]);
      $detail = "type=" . $type
        . " leaves_only=" . var_export($c["settings"]["leaves_only"] ?? null, TRUE)
        . " start_minimized=" . var_export($c["settings"]["start_minimized"] ?? null, TRUE);
    }
  }
  $ok = $cmp && $wid && $lo && $sm;
  print ($ok ? "PASS" : "FAIL") . " cmp=" . ($cmp?1:0) . " wid=" . ($wid?1:0) . " lo=" . ($lo?1:0) . " sm=" . ($sm?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
