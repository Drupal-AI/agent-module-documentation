#!/usr/bin/env bash
# Execution VERIFY: PASS when a view 'dt_task' exists and at least one of its displays uses the
# DataTables style plugin (style.type == datatables).
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $v = \Drupal::entityTypeManager()->getStorage("view")->load("dt_task");
  $uses = FALSE;
  if ($v) {
    foreach ($v->get("display") as $d) {
      if (($d["display_options"]["style"]["type"] ?? "") === "datatables") { $uses = TRUE; break; }
    }
  }
  print ($v && $uses ? "PASS" : "FAIL") . " view=" . ($v?"yes":"no") . " datatables_style=" . ($uses?"yes":"no") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
