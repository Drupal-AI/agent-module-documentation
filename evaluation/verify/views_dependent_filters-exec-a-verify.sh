#!/usr/bin/env bash
# Execution VERIFY: PASS when view vdf_exec_a has a views_dependent_filter handler with
# controller_filter=type and title among its dependent_filters. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal\views\Entity\View::load("vdf_exec_a");
  $ok = FALSE; $ctrl = "none"; $deps = "none";
  if ($v) {
    foreach ($v->get("display")["default"]["display_options"]["filters"] as $f) {
      if (($f["plugin_id"] ?? "") === "views_dependent_filter") {
        $ctrl = $f["controller_filter"] ?? "";
        $deps = implode(",", array_values(array_filter((array) ($f["dependent_filters"] ?? []))));
        if ($ctrl === "type" && in_array("title", array_values(array_filter((array) ($f["dependent_filters"] ?? []))), TRUE)) { $ok = TRUE; }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " controller=$ctrl dependents=$deps\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
