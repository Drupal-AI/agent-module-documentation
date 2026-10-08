#!/usr/bin/env bash
# Execution VERIFY for "enable views_rss_format and build View vrss_fmt_task with an
# Advanced RSS feed row (views_rss_fields) mapping a field to the item <enclosure>
# element, so its url/length/type attributes render correctly". PASS when views_rss_format
# is enabled AND some display has row.type == views_rss_fields with a non-empty
# row.options.item.core.views_rss_core.enclosure. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $module_ok = \Drupal::moduleHandler()->moduleExists("views_rss_format");
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("vrss_fmt_task");
  $row = $enclosure = NULL;
  $view_ok = FALSE;
  if ($view) {
    $data = $view->toArray();
    foreach ($data["display"] ?? [] as $display) {
      $opts = $display["display_options"] ?? [];
      $row_type = $opts["row"]["type"] ?? NULL;
      if ($row_type === "views_rss_fields") {
        $row = $row_type;
        $enclosure = $opts["row"]["options"]["item"]["core"]["views_rss_core"]["enclosure"] ?? NULL;
        if (!empty($enclosure)) {
          $view_ok = TRUE;
        }
      }
    }
  }
  $ok = $module_ok && $view_ok;
  print ($ok ? "PASS" : "FAIL") . " module_enabled=" . var_export($module_ok, TRUE) . " row=" . var_export($row, TRUE) . " enclosure=" . var_export($enclosure, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
