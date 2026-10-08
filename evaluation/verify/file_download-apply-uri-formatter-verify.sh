#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fd_uri component uses file_download_uri_formatter with
# settings.absolute_url === TRUE. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fd_uri") : NULL;
  $type = $c["type"] ?? "none";
  $abs = $c["settings"]["absolute_url"] ?? NULL;
  $ok = ($type === "file_download_uri_formatter" && $abs == TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " absolute_url=" . var_export($abs, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
