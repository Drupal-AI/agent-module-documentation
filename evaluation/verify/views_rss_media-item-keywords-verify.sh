#!/usr/bin/env bash
# Execution VERIFY for "build View vrss_media_keywords with an Advanced RSS feed row
# (views_rss_fields) mapping a field to the item <media:keywords> element". PASS when some
# display has row.type == views_rss_fields and
# row.options.item.media.views_rss_media.keywords is non-empty. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("vrss_media_keywords");
  $ok = FALSE;
  $row = $keywords = NULL;
  if ($view) {
    $data = $view->toArray();
    foreach ($data["display"] ?? [] as $display) {
      $opts = $display["display_options"] ?? [];
      $row_type = $opts["row"]["type"] ?? NULL;
      if ($row_type === "views_rss_fields") {
        $row = $row_type;
        $keywords = $opts["row"]["options"]["item"]["media"]["views_rss_media"]["keywords"] ?? NULL;
        if (!empty($keywords)) {
          $ok = TRUE;
        }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " row=" . var_export($row, TRUE) . " keywords=" . var_export($keywords, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
