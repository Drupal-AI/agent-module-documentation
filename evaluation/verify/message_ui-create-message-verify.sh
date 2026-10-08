#!/usr/bin/env bash
# Execution VERIFY: PASS when at least one Message of template 'message_ui_hard' exists.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $ids = \Drupal::entityQuery("message")->accessCheck(FALSE)->condition("template","message_ui_hard")->execute();
  print (count($ids) >= 1 ? "PASS" : "FAIL")." messages=".count($ids)."\n";
' 2>/dev/null)
echo "$out"; echo "$out" | grep -q '^PASS' && exit 0 || exit 1
