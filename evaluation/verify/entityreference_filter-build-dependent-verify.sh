#!/usr/bin/env bash
# SPDX-License-Identifier: GPL-2.0-or-later
# Execution VERIFY for the "build view `eval_erf_dep` with a DEPENDENT (cascading)
# entityreference_filter" task: its reference_arguments must reference another exposed
# filter via a [identifier] token, which is what makes the option list recompute over AJAX.
# Prints PASS/FAIL; exits 0 (pass) / 1 (fail).
# PASS requires all of:
#   view — a View config entity `eval_erf_dep` exists
#   plug — some display has a filter whose plugin_id is entityreference_filter_view_result
#   ref  — that filter's reference_display is non-empty
#   dep  — that filter's reference_arguments contains a [identifier] token (a "[")
set -uo pipefail
cd /var/www/html

out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("eval_erf_dep");
  $has_view = (bool) $view;
  $plug = FALSE; $ref = FALSE; $dep = FALSE;
  if ($has_view) {
    foreach ($view->get("display") as $display) {
      foreach (($display["display_options"]["filters"] ?? []) as $f) {
        if (($f["plugin_id"] ?? "") === "entityreference_filter_view_result") {
          $plug = TRUE;
          if (trim((string) ($f["reference_display"] ?? "")) !== "") { $ref = TRUE; }
          if (strpos((string) ($f["reference_arguments"] ?? ""), "[") !== FALSE) { $dep = TRUE; }
        }
      }
    }
  }
  $pass = $has_view && $plug && $ref && $dep;
  print ($pass ? "PASS" : "FAIL")
    . " view=" . ($has_view?1:0) . " plug=" . ($plug?1:0)
    . " ref=" . ($ref?1:0) . " dependent=" . ($dep?1:0) . "\n";
' 2>/dev/null)

echo "$out"
echo "$out" | grep -q "^PASS" && exit 0 || exit 1
