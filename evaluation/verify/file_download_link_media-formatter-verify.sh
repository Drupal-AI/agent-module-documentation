#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fdlm_task uses the file_download_link_media formatter.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fdlm_task") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "file_download_link_media") ? "PASS" : "FAIL") . " formatter=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
