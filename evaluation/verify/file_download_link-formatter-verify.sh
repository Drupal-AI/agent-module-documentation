#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fdl_task's display component uses the file_download_link
# formatter. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fdl_task") : NULL;
  $t = $c["type"] ?? "none";
  print (($t === "file_download_link") ? "PASS" : "FAIL") . " formatter=" . $t . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
