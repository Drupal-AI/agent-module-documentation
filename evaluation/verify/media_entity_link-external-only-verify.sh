#!/usr/bin/env bash
# Execution VERIFY: PASS when the Link media type's link field allows external URLs only
# (link_type=16). exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $lt = \Drupal::config("field.field.media.link.field_media_entity_link")->get("settings.link_type");
  print (((int) $lt === 16) ? "PASS" : "FAIL") . " link_type=" . var_export($lt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
