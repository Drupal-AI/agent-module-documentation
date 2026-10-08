#!/usr/bin/env bash
# Execution VERIFY for "build View vrss_dc_rights with an Advanced RSS feed row
# (views_rss_fields) mapping a field to the item <dc:rights> element". PASS when some
# display has row.type == views_rss_fields and row.options.item.dc.views_rss_dc.rights is
# non-empty. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("vrss_dc_rights");
  $ok = FALSE;
  $row = $rights = NULL;
  if ($view) {
    $data = $view->toArray();
    foreach ($data["display"] ?? [] as $display) {
      $opts = $display["display_options"] ?? [];
      $row_type = $opts["row"]["type"] ?? NULL;
      if ($row_type === "views_rss_fields") {
        $row = $row_type;
        $rights = $opts["row"]["options"]["item"]["dc"]["views_rss_dc"]["rights"] ?? NULL;
        if (!empty($rights)) {
          $ok = TRUE;
        }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " row=" . var_export($row, TRUE) . " rights=" . var_export($rights, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
