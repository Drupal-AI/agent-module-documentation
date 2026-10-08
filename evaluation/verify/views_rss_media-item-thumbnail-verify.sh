#!/usr/bin/env bash
# Execution VERIFY for "build View vrss_media_thumbnail with an Advanced RSS feed row
# (views_rss_fields) mapping a field to the item <media:thumbnail> element". PASS when some
# display has row.type == views_rss_fields and
# row.options.item.media.views_rss_media.thumbnail is non-empty. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $view = \Drupal::entityTypeManager()->getStorage("view")->load("vrss_media_thumbnail");
  $ok = FALSE;
  $row = $thumb = NULL;
  if ($view) {
    $data = $view->toArray();
    foreach ($data["display"] ?? [] as $display) {
      $opts = $display["display_options"] ?? [];
      $row_type = $opts["row"]["type"] ?? NULL;
      if ($row_type === "views_rss_fields") {
        $row = $row_type;
        $thumb = $opts["row"]["options"]["item"]["media"]["views_rss_media"]["thumbnail"] ?? NULL;
        if (!empty($thumb)) {
          $ok = TRUE;
        }
      }
    }
  }
  print ($ok ? "PASS" : "FAIL") . " row=" . var_export($row, TRUE) . " thumbnail=" . var_export($thumb, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
