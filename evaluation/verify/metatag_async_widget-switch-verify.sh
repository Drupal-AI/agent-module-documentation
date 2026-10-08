#!/usr/bin/env bash
# Execution VERIFY: PASS when field_maw_task's component in the default form display uses the
# async widget metatag_async_widget_firehose. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c=$fd ? $fd->getComponent("field_maw_task") : NULL;
  $t=$c["type"] ?? "none";
  print (($t==="metatag_async_widget_firehose")?"PASS":"FAIL")." widget=$t\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
