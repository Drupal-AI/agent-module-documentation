#!/usr/bin/env bash
# Execution VERIFY: PASS when a field named field_mg_caption is attached to the media_gallery
# bundle (FieldConfig on media_gallery.media_gallery). Prints PASS/FAIL; exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  use Drupal\field\Entity\FieldConfig;
  $fc = FieldConfig::loadByName("media_gallery", "media_gallery", "field_mg_caption");
  $ok = ($fc !== NULL);
  print ($ok ? "PASS" : "FAIL") . " type=" . ($fc ? $fc->getType() : "none") . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
