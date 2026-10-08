#!/usr/bin/env bash
# Execution VERIFY: PASS when the media 'document' default display renders its thumbnail with the
# media_pdf_thumbnail_image_field_formatter. exit 0 pass / 1 fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $d = \Drupal::entityTypeManager()->getStorage("entity_view_display")->load("media.document.default");
  $c = $d ? $d->getComponent("thumbnail") : NULL;
  $type = $c["type"] ?? NULL;
  $ok = ($type === "media_pdf_thumbnail_image_field_formatter");
  print ($ok ? "PASS" : "FAIL") . " thumbnail.type=" . var_export($type, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
