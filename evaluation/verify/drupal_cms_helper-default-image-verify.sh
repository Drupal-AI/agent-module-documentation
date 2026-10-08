#!/usr/bin/env bash
# Execution VERIFY (hard): confirm the media image field (media.image.field_media_image) has its
# default image set to the expected file UUID via drupal_cms_helper's `setDefaultImage` config
# action. Prints PASS/FAIL and exits 0 (pass) / 1 (fail). No arguments.
#
# Expected UUID: 12345678-90ab-cdef-1234-567890abcdef (a file that need not exist — that is the
# whole point of the action). Reads the live field config.
set -uo pipefail
cd /var/www/html
EXPECT="12345678-90ab-cdef-1234-567890abcdef"

out=$(drush php:eval '
  $uuid = \Drupal::config("field.field.media.image.field_media_image")->get("settings.default_image.uuid");
  print "UUID=" . ($uuid ?? "NULL") . "\n";
' 2>/dev/null | grep '^UUID=')

echo "$out"
if [ "$out" = "UUID=$EXPECT" ]; then
  echo "PASS: default image UUID set to $EXPECT"
  exit 0
else
  echo "FAIL: default image UUID is not $EXPECT"
  exit 1
fi
