#!/usr/bin/env bash
# Live-state verification for the "term_reference_tree widget, cascading selection on Article"
# task. Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Three independent checks against real entity_form_display config:
#   cmp  — node.article default form display has a component for field_eval_trt
#   wid  — that component's widget type is exactly `term_reference_tree`
#   cs   — its settings set cascading_selection to 1 (select + deselect)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $cmp = FALSE; $wid = FALSE; $cs = FALSE; $type = ""; $detail = "";
  $fd = \Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  if ($fd) {
    $c = $fd->getComponent("field_eval_trt");
    if (is_array($c)) {
      $cmp = TRUE;
      $type = $c["type"] ?? "";
      if ($type === "term_reference_tree") { $wid = TRUE; }
      $val = $c["settings"]["cascading_selection"] ?? "";
      if ((string) $val === "1") { $cs = TRUE; }
      $detail = "type=" . $type . " cascading_selection=" . var_export($val, TRUE);
    }
  }
  $ok = $cmp && $wid && $cs;
  print ($ok ? "PASS" : "FAIL") . " cmp=" . ($cmp?1:0) . " wid=" . ($wid?1:0) . " cs=" . ($cs?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
