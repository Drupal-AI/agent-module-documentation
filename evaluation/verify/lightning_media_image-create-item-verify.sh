#!/usr/bin/env bash
# Execution VERIFY: PASS when a media item named 'LM Image Task' exists in the image bundle,
# field_media_image references a file, and its alt text is exactly 'LM hero'.
# exit 0 = pass, 1 = fail.
set -uo pipefail
cd /var/www/html
out=$(drush php:eval '
  $found = \Drupal::entityTypeManager()->getStorage("media")->loadByProperties(["name" => "LM Image Task"]);
  $m = $found ? reset($found) : NULL;
  $value = ($m && $m->hasField("field_media_image")) ? $m->get("field_media_image")->getValue() : [];
  $alt = $value ? ($value[0]["alt"] ?? NULL) : NULL;
  $checks = [
    "exists" => (bool) $m,
    "bundle" => $m && $m->bundle() === "image",
    "source_field" => (bool) $value,
    "alt_text" => (trim((string) $alt) === "LM hero"),
  ];
  $bad = array_keys(array_filter($checks, fn ($v) => !$v));
  print ($bad ? "FAIL wrong=" . implode(",", $bad) : "PASS") . " bundle=" . ($m ? $m->bundle() : "none") . " alt=" . var_export($alt, TRUE) . "\n";
' 2>/dev/null)
echo "$out"
echo "$out" | grep -q '^PASS' && exit 0 || exit 1
