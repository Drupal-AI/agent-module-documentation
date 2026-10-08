#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution VERIFY for the "build a Content view `eval_erf_build` with an EXPOSED
# entityreference_filter" task. Prints PASS/FAIL; exits 0 (pass) / 1 (fail).
# PASS requires all of:
#   view — a View config entity `eval_erf_build` exists
#   plug — some display has a filter whose plugin_id is entityreference_filter_view_result
#   exp  — that filter is exposed
#   ref  — that filter's reference_display is non-empty (points at a reference view display)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("eval_erf_build");
  $has_view = (bool) $view;
  $plug = FALSE; $exp = FALSE; $ref = FALSE;
  if ($has_view) {
    foreach ($view->get("display") as $display) {
      foreach (($display["display_options"]["filters"] ?? []) as $f) {
        if (($f["plugin_id"] ?? "") === "entityreference_filter_view_result") {
          $plug = TRUE;
          if (!empty($f["exposed"])) { $exp = TRUE; }
          if (trim((string) ($f["reference_display"] ?? "")) !== "") { $ref = TRUE; }
        }
      }
    }
  }
  $pass = $has_view && $plug && $exp && $ref;
  print ($pass ? "PASS" : "FAIL")
    . " view=" . ($has_view?1:0) . " plug=" . ($plug?1:0)
    . " exp=" . ($exp?1:0) . " ref=" . ($ref?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
