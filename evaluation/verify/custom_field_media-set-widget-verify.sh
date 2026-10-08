#!/usr/bin/env bash
# Execution VERIFY: PASS when field_cfmedia_disp 'image' column widget is media_library_widget.
# exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd = \Drupal::service("entity_display.repository")->getFormDisplay("node","cfmedia_eval","default");
  $c = $fd->getComponent("field_cfmedia_disp");
  $w = $c["settings"]["fields"]["image"]["type"] ?? "none";
  $ok = ($w === "media_library_widget");
  print ($ok?"PASS":"FAIL")." widget=".$w."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
