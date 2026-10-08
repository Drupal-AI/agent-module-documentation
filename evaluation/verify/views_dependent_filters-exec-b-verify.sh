#!/usr/bin/env bash
# Execution VERIFY: PASS when vdf_exec_b has a views_dependent_filter with controller=type,
# title as dependent, AND condition = not_empty. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("vdf_exec_b");
  $ok = FALSE; $ctrl = "none"; $cond = "none"; $deps = "none";
  if ($v) {
    foreach ($v->get("display")["default"]["display_options"]["filters"] as $f) {
      if (($f["plugin_id"] ?? "") === "views_dependent_filter") {
        $ctrl = $f["controller_filter"] ?? "";
        $cond = $f["condition"] ?? "";
        $dl = array_values(array_filter((array) ($f["dependent_filters"] ?? [])));
        $deps = implode(",", $dl);
        if ($ctrl === "type" && $cond === "not_empty" && in_array("title", $dl, TRUE)) { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " controller=$ctrl condition=$cond dependents=$deps\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
