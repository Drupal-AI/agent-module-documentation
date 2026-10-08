#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fdl_link uses file_download_link with link_text 'Download PDF'.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fdl_link") : NULL;
  $t = $c["type"] ?? "none";
  $lt = $c["settings"]["link_text"] ?? NULL;
  $ok = ($t === "file_download_link") && ($lt === "Download PDF");
  print ($ok ? "PASS" : "FAIL") . " formatter=" . $t . " link_text=" . var_export($lt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
