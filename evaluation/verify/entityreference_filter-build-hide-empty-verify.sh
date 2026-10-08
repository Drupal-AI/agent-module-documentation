#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution VERIFY for the "build view `eval_erf_hide` with an EXPOSED entityreference_filter
# whose 'Hide empty filter' is turned OFF" task. Prints PASS/FAIL; exits 0 (pass) / 1 (fail).
# PASS requires all of:
#   view — a View config entity `eval_erf_hide` exists
#   plug — some display has a filter whose plugin_id is entityreference_filter_view_result
#   ref  — that filter's reference_display is non-empty
#   hide — that filter's hide_empty_filter is explicitly FALSE (default is TRUE)
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("eval_erf_hide");
  $has_view = (bool) $view;
  $plug = FALSE; $ref = FALSE; $hide = FALSE;
  if ($has_view) {
    foreach ($view->get("display") as $display) {
      foreach (($display["display_options"]["filters"] ?? []) as $f) {
        if (($f["plugin_id"] ?? "") === "entityreference_filter_view_result") {
          $plug = TRUE;
          if (trim((string) ($f["reference_display"] ?? "")) !== "") { $ref = TRUE; }
          if (array_key_exists("hide_empty_filter", $f) && $f["hide_empty_filter"] === FALSE) { $hide = TRUE; }
        }
      }
    }
  }
  $pass = $has_view && $plug && $ref && $hide;
  print ($pass ? "PASS" : "FAIL")
    . " view=" . ($has_view?1:0) . " plug=" . ($plug?1:0)
    . " ref=" . ($ref?1:0) . " hide_off=" . ($hide?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
