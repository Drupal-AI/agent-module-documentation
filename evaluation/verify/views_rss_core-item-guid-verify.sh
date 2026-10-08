#!/usr/bin/env bash
# Execution VERIFY for "build View vrss_c_guid with an Advanced RSS feed row (views_rss_fields)
# mapping a field to the item <guid> element". PASS when some display has row.type ==
# views_rss_fields and row.options.item.core.views_rss_core.guid is non-empty. Exit 0 pass /
# 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("vrss_c_guid");
  $ok = FALSE;
  $row = $guid = NULL;
  if ($view) {
    $data = $view->toArray();
    foreach ($data["display"] ?? [] as $display) {
      $opts = $display["display_options"] ?? [];
      $row_type = $opts["row"]["type"] ?? NULL;
      if ($row_type === "views_rss_fields") {
        $row = $row_type;
        $guid = $opts["row"]["options"]["item"]["core"]["views_rss_core"]["guid"] ?? NULL;
        if (!empty($guid)) {
          $ok = TRUE;
        }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " row=" . var_export($row, TRUE) . " guid=" . var_export($guid, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
