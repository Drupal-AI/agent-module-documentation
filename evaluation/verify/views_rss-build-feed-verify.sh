#!/usr/bin/env bash
# Execution VERIFY for "build View vrss_p_task with an Advanced RSS feed (rss_fields /
# views_rss_fields) display, item title mapped to a field". PASS when some display on
# vrss_p_task has style.type == rss_fields, row.type == views_rss_fields, and a non-empty
# item title mapping under row.options.item.*.*.title. Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("vrss_p_task");
  $ok = FALSE;
  $style = $row = $title_field = NULL;
  if ($view) {
    $data = $view->toArray();
    foreach ($data["display"] ?? [] as $display) {
      $opts = $display["display_options"] ?? [];
      $style_type = $opts["style"]["type"] ?? NULL;
      $row_type = $opts["row"]["type"] ?? NULL;
      if ($style_type === "rss_fields" && $row_type === "views_rss_fields") {
        $item = $opts["row"]["options"]["item"] ?? [];
        foreach ($item as $namespace_elems) {
          foreach ($namespace_elems as $module_elems) {
            if (!empty($module_elems["title"])) {
              $title_field = $module_elems["title"];
            }
          }
        }
        $style = $style_type;
        $row = $row_type;
        if (!empty($title_field)) {
          $ok = TRUE;
        }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " style=" . var_export($style, TRUE) . " row=" . var_export($row, TRUE) . " title_field=" . var_export($title_field, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
