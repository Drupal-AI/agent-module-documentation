#!/usr/bin/env bash
# Execution VERIFY: PASS when the view 'vfs_task' has a views_filters_summary AREA handler
# (plugin_id 'views_filters_summary') in any display's header/footer/empty region. Prints PASS/FAIL.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\views\Entity\View;
  $v = View::load("vfs_task");
  $found = FALSE;
  if ($v) {
    foreach ($v->get("display") as $display) {
      foreach (["header","footer","empty"] as $region) {
        foreach (($display["display_options"][$region] ?? []) as $h) {
          if (($h["plugin_id"] ?? NULL) === "views_filters_summary") { $found = TRUE; }
        }
      }
    }
  }
  print ($found ? "PASS" : "FAIL") . " view=" . ($v ? "vfs_task" : "missing") . " area=" . var_export($found, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
