#!/usr/bin/env bash
# Execution VERIFY: PASS when Template Map mtt_edit has content_area == 'body_region'. exit 0/1.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $e = \Drupal::entityTypeManager()->getStorage("mailchimp_transactional_template")->load("mtt_edit");
  $ca = $e ? ($e->content_area ?? NULL) : NULL;
  print (($ca === "body_region") ? "PASS" : "FAIL") . " content_area=" . var_export($ca, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
