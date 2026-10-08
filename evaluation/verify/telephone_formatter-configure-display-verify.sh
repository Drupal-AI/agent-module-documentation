#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Live-state verification for the telephone_formatter "configure the display" hard task.
# Prints PASS/FAIL with detail and exits 0 (pass) / 1 (fail). No arguments.
# Checks the node.article.default entity_view_display component for field_eval_tel:
#   fmt  — the field's display formatter is telephone_formatter
#   set  — its settings are format = 3 (RFC3966) and link = TRUE
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $fmt = FALSE; $set = FALSE; $detail = "";
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  if ($vd && ($c = $vd->getComponent("field_eval_tel"))) {
    $type = $c["type"] ?? "";
    $format = $c["settings"]["format"] ?? "unset";
    $link = $c["settings"]["link"] ?? "unset";
    if ($type === "telephone_formatter") { $fmt = TRUE; }
    if ((int) $format === 3 && (bool) $link === TRUE) { $set = TRUE; }
    $detail = "type=" . $type . " format=" . $format . " link=" . var_export($link, TRUE);
  } else {
    $detail = "no component for field_eval_tel";
  }
  $ok = $fmt && $set;
  print ($ok ? "PASS" : "FAIL") . " fmt=" . ($fmt?1:0) . " set=" . ($set?1:0) . " " . $detail . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
