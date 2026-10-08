#!/usr/bin/env bash
# Execution VERIFY for "build View vrss_dc_creator with an Advanced RSS feed row
# (views_rss_fields) mapping a field to the item <dc:creator> element". PASS when some
# display has row.type == views_rss_fields and row.options.item.dc.views_rss_dc.creator is
# non-empty. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("vrss_dc_creator");
  $ok = FALSE;
  $row = $creator = NULL;
  if ($view) {
    $data = $view->toArray();
    foreach ($data["display"] ?? [] as $display) {
      $opts = $display["display_options"] ?? [];
      $row_type = $opts["row"]["type"] ?? NULL;
      if ($row_type === "views_rss_fields") {
        $row = $row_type;
        $creator = $opts["row"]["options"]["item"]["dc"]["views_rss_dc"]["creator"] ?? NULL;
        if (!empty($creator)) {
          $ok = TRUE;
        }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " row=" . var_export($row, TRUE) . " creator=" . var_export($creator, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
