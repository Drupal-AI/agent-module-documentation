#!/usr/bin/env bash
# Execution VERIFY: PASS when field_fd_task component in node.article.default uses
# file_download_formatter with settings.file_size === TRUE. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $vd = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("node.article.default");
  $c = $vd ? $vd->getComponent("field_fd_task") : NULL;
  $type = $c["type"] ?? "none";
  $fs = $c["settings"]["file_size"] ?? NULL;
  $ok = ($type === "file_download_formatter" && $fs == TRUE);
  print ($ok ? "PASS" : "FAIL") . " type=" . $type . " file_size=" . var_export($fs, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
