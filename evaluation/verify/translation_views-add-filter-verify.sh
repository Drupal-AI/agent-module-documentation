#!/usr/bin/env bash
# Execution VERIFY: PASS when view tv_task's config references the translation_views
# target-language handler (plugin_id translation_views_target_language) anywhere in its display.
# Exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $data=\Drupal::config("views.view.tv_task")->getRawData();
  $json = $data ? json_encode($data) : "";
  $ok = ($json && strpos($json, "translation_views_target_language") !== FALSE);
  print ($ok?"PASS":"FAIL")."\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
