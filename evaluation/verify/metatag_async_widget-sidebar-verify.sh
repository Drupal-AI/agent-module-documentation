#!/usr/bin/env bash
# Execution VERIFY: PASS when field_maw_task2 uses the async widget AND its 'sidebar' setting is
# truthy. Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $fd=\Drupal::entityTypeManager()->getStorage("entity_form_display")->load("node.article.default");
  $c=$fd ? $fd->getComponent("field_maw_task2") : NULL;
  $t=$c["type"] ?? "none";
  $sb=$c["settings"]["sidebar"] ?? null;
  $ok=($t==="metatag_async_widget_firehose" && !empty($sb));
  print (($ok)?"PASS":"FAIL")." widget=$t sidebar=".var_export($sb,true)."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
